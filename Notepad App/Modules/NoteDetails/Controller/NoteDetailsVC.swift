//
//  NoteDetailsVC.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/14/21.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

class NoteDetailsVC: BaseWireFrame<NoteDetailsViewModel> {

    @IBOutlet weak var title_TextView: DesignableUITextView!
    @IBOutlet weak var body_TextView: DesignableUITextView!
    @IBOutlet weak var addLocation_Btn: UIButton!
    @IBOutlet weak var addPhoto_Btn: UIButton!
    @IBOutlet weak var selectedPhoto_ImgView: UIImageView!
    @IBOutlet weak var location_lbl: UILabel!
    @IBOutlet weak var addPhoto_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
   
    override func bind(viewModel: NoteDetailsViewModel) {
        setInitValueNote()
        //input
        title_TextView.rx.text.orEmpty.filter {$0 != self.title_TextView.placeHolder}.bind(to: self.viewModel.inputs.titleBehavior).disposed(by: disposeBag)
        body_TextView.rx.text.orEmpty.filter {$0 != self.body_TextView.placeHolder}.bind(to: self.viewModel.inputs.bodyBehavior).disposed(by: disposeBag)

        subscribeToActionSuccessfully()
        subscribeToAddPhotoTapped()
        handleAddLocationAppearing()
    }
    private func setInitValueNote(){
        title_TextView.text = self.viewModel.inputs.titleBehavior.value
        body_TextView.text = self.viewModel.inputs.bodyBehavior.value
        selectedPhoto_ImgView.image = self.viewModel.inputs.photoBehavior.value
        let location = CLLocation(latitude: self.viewModel.inputs.latBehacior.value ?? 0, longitude:self.viewModel.inputs.longBehacior.value ?? 0 ).getAddressName()
        location_lbl.text = location.isEmpty ? "Add location":location
        handleLocation_lbl()
        handlePhotoAppearing()
    }
    
    private func subscribeToActionSuccessfully(){
        let shouldCloseScreen:PublishSubject<Void> = .init()
        shouldCloseScreen.subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        viewModel.outputs.addedSuccessfully.subscribe(onNext: {[weak self] (isSuccessfully) in
            guard let self = self, isSuccessfully else {return}
            AlertManager.showMessage(vc: self, title: "Success", message: "Note saved successfully", observable: shouldCloseScreen)
        }).disposed(by: disposeBag)
        
        viewModel.outputs.deletedSuccessfully.subscribe(onNext: {[weak self] (isSuccessfully) in
            guard let self = self, isSuccessfully else {return}
            AlertManager.showMessage(vc: self, title: "Success", message: "Note deleted successfully", observable: shouldCloseScreen)
        }).disposed(by: disposeBag)

    }

    private func subscribeToAddPhotoTapped(){
        addPhoto_Btn.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            Helper.presentPhotoInputActionsheet(vc: self)
        }.disposed(by: disposeBag)
    }
    
    private func handlePhotoAppearing(){
        selectedPhoto_ImgView.isHidden = selectedPhoto_ImgView.image != nil ? false:true
        let addButtonTitle = selectedPhoto_ImgView.image != nil ? "":"Add photo"
        addPhoto_lbl.text = addButtonTitle
        
    }
    
    private func handleAddLocationAppearing(){
        addLocation_Btn.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            LocationManager.shared.getCurrentLocation()
            LocationManager.shared.locationObservable.subscribe(onNext: {[weak self] (location) in
                self?.viewModel.inputs.latBehacior.accept(location.coordinate.latitude)
                self?.viewModel.inputs.longBehacior.accept(location.coordinate.longitude)
                print(location.coordinate.latitude,"latttttttttt-------")
                print(location.coordinate.longitude,"long-------")
                DispatchQueue.main.async {
                    self?.location_lbl.text = location.getAddressName()
                    self?.handleLocation_lbl()
                }
            }).disposed(by: self.disposeBag)
        }.disposed(by: self.disposeBag)
        
    }
    private func handleLocation_lbl(){
        if location_lbl.text == "Add location"{
            location_lbl.textColor = DesignSystem.Colors.meduimGray.color
        }
        else {
            location_lbl.textColor = .black
        }
    }
}
//MARK:- SetUpUI add two buttons to navigationBar [Add, Delete]
extension NoteDetailsVC{
    private func setupNavigationButtons(){
        var items = [UIBarButtonItem]()
        if self.viewModel.outputs.noteState == .add {
            items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped)))
        }
        else {
            items.append(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTapped)))
            items.append(UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped)))
        }
        navigationItem.rightBarButtonItems = items
    }
    
    @objc func addTapped(){
        if self.viewModel.isVaildNote(){
            self.viewModel.inputs.saveNote()
        }
    }
    
    @objc func deleteTapped(){
        handleMessagesForDeleteNote()
    }
}
//MARK:- Handle Messages
extension NoteDetailsVC{
    private func handleMessagesForDeleteNote(){
        let deleteObservable:PublishSubject<Void> = .init()
        
        deleteObservable.subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.viewModel.inputs.deleteNote()
        }.disposed(by: disposeBag)
        
        let message =  "Are you sure you want to delete this note?"
        AlertManager.showAlertMessage(vc: self, coordinator: coordinator, title: ("", nil), message: (message, color: .black), actions: ("Cancel".localized(), nil, DesignSystem.Colors.primary.color),("Delete".localized(), deleteObservable, .red))
        
    }
}

//MARK: - UIImagePickerControllerDelegate
extension NoteDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            self.viewModel.inputs.photoBehavior.accept(image)
            self.selectedPhoto_ImgView.image = image
            handlePhotoAppearing()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}


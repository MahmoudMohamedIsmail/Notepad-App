//
//  NoteDetailsVC.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/14/21.
//

import UIKit
import RxCocoa
import RxSwift

class NoteDetailsVC: BaseWireFrame<NoteDetailsViewModel> {

    @IBOutlet weak var title_TextView: DesignableUITextView!
    @IBOutlet weak var body_TextView: DesignableUITextView!
    @IBOutlet weak var addLocation_Btn: UIButton!
    @IBOutlet weak var addPhoto_Btn: UIButton!
    @IBOutlet weak var selectedPhoto_ImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationButtons()
    }
    
   
    override func bind(viewModel: NoteDetailsViewModel) {
        setInitValueNote()
        //input
        title_TextView.rx.text.orEmpty.bind(to: self.viewModel.inputs.titleBehavior).disposed(by: disposeBag)
        body_TextView.rx.text.orEmpty.bind(to: self.viewModel.inputs.bodyBehavior).disposed(by: disposeBag)
        subscribeToActionSuccessfully()
    }
    private func setInitValueNote(){
        title_TextView.text = self.viewModel.inputs.titleBehavior.value
        body_TextView.text = self.viewModel.inputs.bodyBehavior.value
        selectedPhoto_ImgView.image = self.viewModel.inputs.photoBehavior.value
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

}
//MARK:- SetUpUI add two buttons to navigationBar [Add, Delete]
extension NoteDetailsVC{
    private func setupNavigationButtons(){
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let delete = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(deleteTapped))
        navigationItem.rightBarButtonItems = [add, delete]
    }
    
    @objc func addTapped(){
        self.viewModel.inputs.saveNote()
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


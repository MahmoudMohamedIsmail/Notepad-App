//
//  NotesVC.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/13/21.
//

import UIKit

class NotesVC: BaseWireFrame<NotesViewModel> {
    
    @IBOutlet weak var notes_TableVeiw: UITableView!{
        didSet{
            notes_TableVeiw.registerCellNib(cellClass: NoteCell.self)
            notes_TableVeiw.contentInset = .init(top: 10, left: 0, bottom: 34, right: 0) // 34 For Unclickable Area
            notes_TableVeiw.tableFooterView = UIView() // to hide bottom seprators
        }
    }
    
    lazy var noNotesViwe:NoNotesView = {
        return NoNotesView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bind(viewModel: NotesViewModel) {
        subscribeToEmptyList()
        subscribeToAddButtonWhenNoNotes()
        bindNotesToTableView()
    }
    private func subscribeToEmptyList(){
        viewModel.outputs.isEmptyList.subscribe(onNext: { [weak self](isEmpty) in
            guard let self = self else {return}
            self.notes_TableVeiw.backgroundView = isEmpty ? self.noNotesViwe:nil
        }).disposed(by: disposeBag)
    }
    private func subscribeToAddButtonWhenNoNotes(){
        noNotesViwe.add_Btn.rx.tap.subscribe {[weak self] (_) in
            print("Add Note....")
        }.disposed(by: disposeBag)
    }
    private func bindNotesToTableView(){
        viewModel.outputs.notesObservable.bind(to: notes_TableVeiw.rx.items(cellIdentifier: NoteCell.identifier, cellType: NoteCell.self)){ [weak self](row, model, cell) in
            guard let self = self else {return}
        }.disposed(by: disposeBag)
    }
    
}

//
//  NoteDetailsViewModel.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/14/21.
//

import RxSwift
import RxRelay

enum NoteState {
    case add // defult value 
    case edit
}
protocol NoteDetailsViewModelInput {
    var titleBehavior:BehaviorRelay<String>{get set}
    var bodyBehavior:BehaviorRelay<String>{get set}
    var photoBehavior:BehaviorRelay<UIImage?>{get set}
    func saveNote()
    func deleteNote()
}
protocol NoteDetailsViewModelOutput {
    
    var addedSuccessfully:BehaviorRelay<Bool>{get set}
    var deletedSuccessfully:BehaviorRelay<Bool>{get set}
}

class NoteDetailsViewModel: BaseViewModel, NoteDetailsViewModelInput, NoteDetailsViewModelOutput {
    var inputs:NoteDetailsViewModelInput{return self}
    var outputs:NoteDetailsViewModelOutput{return self}
    
    //inputs
    var titleBehavior: BehaviorRelay<String> = .init(value: "")
    var bodyBehavior: BehaviorRelay<String> = .init(value: "")
    var photoBehavior: BehaviorRelay<UIImage?> = .init(value: nil)
    
    //outputs
    var addedSuccessfully: BehaviorRelay<Bool> = .init(value: false)
    var deletedSuccessfully: BehaviorRelay<Bool> = .init(value: false)
    
    
    lazy private var noteState:NoteState = .add
    lazy private var note:Note = Note()
    
    init(note:Note?) {
        super.init()
        guard let note = note  else {
            return
        }
        noteState = .edit
        self.note = note
        titleBehavior.accept(note.title)
        bodyBehavior.accept(note.body)
        let data = note.photoData
        photoBehavior.accept((data != nil) ?  UIImage(data: data!):nil)
        
    }
    
    func saveNote() {
        let finalNote = Note()
        finalNote.title = titleBehavior.value
        finalNote.body = bodyBehavior.value
        finalNote.photoData = photoBehavior.value?.pngData()
        
        if noteState == .edit {
            addedSuccessfully.accept(RealmManager.shared.editResult(object: self.note, with: finalNote))
            return
        }
        
        addedSuccessfully.accept(RealmManager.shared.addResult(object: finalNote))
    }
    
    func deleteNote() {
        addedSuccessfully.accept(RealmManager.shared.removeResult(object: note))
    }
    
    
    
}

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
    var latBehacior:BehaviorRelay<Double?>{get set}
    var longBehacior:BehaviorRelay<Double?>{get set}
    func saveNote()
    func deleteNote()
}
protocol NoteDetailsViewModelOutput {
    var noteState:NoteState {get set}
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
    var latBehacior: BehaviorRelay<Double?> = .init(value: nil)
    var longBehacior: BehaviorRelay<Double?> = .init(value: nil)
    
    //outputs
    var addedSuccessfully: BehaviorRelay<Bool> = .init(value: false)
    var deletedSuccessfully: BehaviorRelay<Bool> = .init(value: false)
    
    
    var noteState:NoteState = .add
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
        latBehacior.accept(note.lat.value)
        longBehacior.accept(note.long.value)
        let data = note.photoData
        photoBehavior.accept((data != nil) ?  UIImage(data: data! as Data):nil)
        
    }
    
    func isVaildNote() -> Bool{
        guard !titleBehavior.value.trimo.isEmpty else {
            self.showMessageObservable.onNext((nil, "Enter your title".localized()))
            return false
        }
        guard !bodyBehavior.value.trimo.isEmpty else {
            self.showMessageObservable.onNext((nil, "Enter your body".localized()))
            return false
        }
        return true
    }

    func saveNote() {
        let finalNote = Note()
        finalNote.title = titleBehavior.value
        finalNote.body = bodyBehavior.value
        finalNote.photoData = photoBehavior.value?.jpegData(compressionQuality: 0.5).flatMap{NSData(data: $0)}
        finalNote.lat.value = latBehacior.value
        finalNote.long.value = longBehacior.value
        
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

//
//  NotesViewModel.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/13/21.
//

import RxRelay
import RxRealm
import RealmSwift
import RxSwift

protocol NotesViewModelInput {
    
}
protocol NotesViewModleOutput {
    var notesObservable:Observable<Results<Note>>{get}
    var isEmptyList:Observable<Bool>{get}
}
class NotesViewModel: BaseViewModel, NotesViewModelInput, NotesViewModleOutput {
  
    
    var inputs:NotesViewModelInput{return self}
    var outputs:NotesViewModleOutput{return self}
    
//    private var notes:BehaviorRelay<[String]> = .init(value: [])
    var notesObservable: Observable<Results<Note>> {
        return RealmManager.shared.getResults(object: Note.self)
    }
    
    var isEmptyList: Observable<Bool>{
        return RealmManager.shared.getResults(object: Note.self).map {$0.isEmpty}
    }
    
}

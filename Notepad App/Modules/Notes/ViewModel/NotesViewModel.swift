//
//  NotesViewModel.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/13/21.
//

import RxRelay
import RxSwift

protocol NotesViewModelInput {
    
}
protocol NotesViewModleOutput {
    var notesObservable:Observable<[String]>{get}
    var isEmptyList:Observable<Bool>{get}
}
class NotesViewModel: BaseViewModel, NotesViewModelInput, NotesViewModleOutput {
  
    
    var inputs:NotesViewModelInput{return self}
    var outputs:NotesViewModleOutput{return self}
    
    private var notes:BehaviorRelay<[String]> = .init(value: [])
    var notesObservable: Observable<[String]> {
        return notes.asObservable()
    }
    
    var isEmptyList: Observable<Bool>{
        return notes.map{$0.isEmpty}
    }
    
   
    override init() {
//        notes.accept(["","","","","",""])
    }
}

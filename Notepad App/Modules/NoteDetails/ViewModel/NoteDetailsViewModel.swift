//
//  NoteDetailsViewModel.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/14/21.
//

import Foundation
protocol NoteDetailsViewModelInput {
    
}
protocol NoteDetailsViewModelOutput {
    
}

class NoteDetailsViewModel: BaseViewModel, NoteDetailsViewModelInput, NoteDetailsViewModelOutput {
    var inputs:NoteDetailsViewModelInput{return self}
    var outputs:NoteDetailsViewModelOutput{return self}
    
}

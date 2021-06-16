//
//  MainNavigator.swift


import Foundation
import UIKit
import RxCocoa
import RxSwift

class MainNavigator: Navigator{
    
    var coordinator: Coordinator
    
    enum Destination {
     
        // Notes
        case notes
        case noteDetails(note:Note?)
        
        
        
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        
        case .notes:
            let viewController = NotesVC()
            viewController.navigationItem.title = "Notes"
            let viewModel = NotesViewModel()
            viewController.configure(viewModel: viewModel, coordinator: self.coordinator)
            return viewController
        case let .noteDetails(note):
            let viewController = NoteDetailsVC()
            let viewModel = NoteDetailsViewModel(note: note)
            viewController.configure(viewModel: viewModel, coordinator: self.coordinator)
            return viewController
             
        }
    }
    
}

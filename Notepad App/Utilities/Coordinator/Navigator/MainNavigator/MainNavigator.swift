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
        case noteDetails
        
        
        
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
        case .noteDetails:
            let viewController = NoteDetailsVC()
            let viewModel = NoteDetailsViewModel()
            viewController.configure(viewModel: viewModel, coordinator: self.coordinator)
            return viewController
             
        }
    }
    
}

//
//  ViewModel.swift


import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: NSObject{
    
    var disposeBag: DisposeBag = DisposeBag()
    
    lazy var reloadData: PublishSubject<Void> = {
        return .init()
    }()
    
    lazy var showMessageObservable: PublishSubject<(String?, String)> = .init()
    lazy var shouldShowProgress: PublishSubject<Bool> = .init()
    lazy var isRefreshing: PublishSubject<Bool> = .init() 
}

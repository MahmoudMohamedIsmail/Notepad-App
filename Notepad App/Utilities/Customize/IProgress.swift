//
//  IProgress.swift


import Foundation
import iProgressHUD

class IProgress{
    
    static var sharedInstance: IProgress = {return IProgress()}()
    
    var iprogress: iProgressHUD = {
        let iprogress: iProgressHUD = iProgressHUD()
        iprogress.iprogressStyle = .vertical
        iprogress.indicatorStyle = .ballSpinFadeLoader
        iprogress.isShowModal = true
        iprogress.boxSize = 50
        iprogress.indicatorSize = 30
        iprogress.isShowCaption = false
        iprogress.isShowBox = false
        iprogress.isBlurModal = false
        iprogress.indicatorColor = DesignSystem.Colors.primary.color
        return iprogress
    }()
    
    private init() {}
    
    func show(_ currentViewController: UIViewController?){
        guard let view = currentViewController?.view else {return}
        iprogress.attachProgress(toView: view)
        view.showProgress()
    }
    
    @objc
    func hide(_ currentViewController: UIViewController?){
        guard let view = currentViewController?.view else {return}
        view.dismissProgress()
    }
    
}

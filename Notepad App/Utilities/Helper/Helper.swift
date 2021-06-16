//
//  Helper.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/15/21.
//

import Foundation
import UIKit
class Helper{
    
    class func presentPhotoInputActionsheet(vc:UIViewController) {
        let actionSheet = UIAlertController(title: "Attach Photo".localized(),
                                            message: "Where would you like to attach a photo from".localized(),
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera".localized(), style: .default, handler: { _ in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            vc.present(picker, animated: true)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library".localized(), style: .default, handler: { _ in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            vc.present(picker, animated: true)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true)
    }
    
}

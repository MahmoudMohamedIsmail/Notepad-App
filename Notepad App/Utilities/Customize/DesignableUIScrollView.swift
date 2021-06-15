//
//  DesignableUIScrollView.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/15/21.
//

import UIKit

class DesignableUIScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure(){
        var bottomPadding:CGFloat = 20.0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
             bottomPadding += (window?.safeAreaInsets.bottom ?? 0)
            print(bottomPadding)
        }
        self.contentInset = .init(top: 10, left: 0, bottom: bottomPadding, right: 0)
    }

}

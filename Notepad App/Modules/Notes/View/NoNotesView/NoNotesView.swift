//
//  NoNotesView.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/13/21.
//

import UIKit

class NoNotesView: UIView {

    weak var image:UIImageView! {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "note.text")
        } else {
            imageView.image = UIImage(named: "Note_ICON")
        }
        
        return imageView
    }

    weak var body_lbl:UILabel!{
        let lbl = UILabel()
        lbl.text = "Begin by adding your first note"
        lbl.textAlignment = .center
        lbl.font = DesignSystem.Typography.callout.font
        return lbl
    }
    
    lazy var add_Btn:DesignableUIButton = {
        let button = DesignableUIButton()
        button.borderColor = .black
        button.borderWidth = 1
        button.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Add", for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 10, bottom: 8, right: 10)
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVeiw()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVeiw()
    }
    
    private func setupVeiw(){
        let content_StackView = UIStackView()
        content_StackView.axis = .vertical
        content_StackView.alignment = .center
        content_StackView.spacing = 10
        content_StackView.addArrangedSubview(image)
        content_StackView.addArrangedSubview(body_lbl)
        content_StackView.addArrangedSubview(add_Btn)
        
        content_StackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(content_StackView)
        
        NSLayoutConstraint.activate([
            content_StackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            content_StackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
   
}

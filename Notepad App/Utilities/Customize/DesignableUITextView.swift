//
//  DesignableUITextView.swift

import RxCocoa
import RxSwift

class DesignableUITextView: UITextView {

    private let disposeBag: DisposeBag = DisposeBag()
    
    private var currnetTextColor: UIColor = .black
    
    @IBInspectable
    var placeHolder: String = "" {
        didSet {
            self.currnetTextColor = self.textColor ?? .black
            self.textColor = DesignSystem.Colors.meduimGray.color
            self.text = self.placeHolder.localized()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    private func initialize(){
        
        self.textContainerInset = .init(top: 10, left: 5, bottom: 10, right: 5)
        self.tintColor = DesignSystem.Colors.primary.color
        
        self.rx.didBeginEditing.subscribe {[weak self] (_) in
            guard let self = self else {return}
            if self.text.localized() == self.placeHolder.localized() {
                self.text = nil
            }
            self.textColor = self.currnetTextColor
            self.textColor = DesignSystem.Colors.blackText.color
            self.borderColor = DesignSystem.Colors.primary.color
        }.disposed(by: self.disposeBag)
        
        self.rx.didEndEditing.subscribe {[weak self] (_) in
            guard let self = self else {return}
            if self.text?.count == 0 {
                self.textColor = DesignSystem.Colors.meduimGray.color
                self.textColor = DesignSystem.Colors.meduimGray.color
                self.text = self.placeHolder.localized()
                self.borderColor = DesignSystem.Colors.meduimGray.color
            }
        }.disposed(by: self.disposeBag)
        
    }
    
}

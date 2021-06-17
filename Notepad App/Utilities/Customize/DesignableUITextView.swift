//
//  DesignableUITextView.swift

import RxCocoa
import RxSwift
enum UITextViewState{
    case isPlaceHolder // only display placeholder
    case isEmpty // only empty no placeholder no text
    case isText // only text
}
class DesignableUITextView: UITextView {

    private let disposeBag: DisposeBag = DisposeBag()
    
    private var currnetTextColor: UIColor = .black
    
    @IBInspectable
    var placeHolder: String = "" {
        didSet {
            self.text = self.placeHolder.localized()
            self.handleUI()
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
    
    private var currentState:UITextViewState = .isPlaceHolder {
        didSet{
            switch self.currentState {
            case .isPlaceHolder:
                handleUI(isPlaceHolder: true)
            case .isEmpty:
                handleUI(isPlaceHolder: false)
            case .isText:
                handleUI(isPlaceHolder: false)
            }
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
            switch self.currentState {
            case .isPlaceHolder:
                self.text = nil
                self.currentState = .isEmpty
            case .isEmpty, .isText:
                break
            }
        }.disposed(by: self.disposeBag)

        self.rx.didEndEditing.subscribe {[weak self] (_) in
            guard let self = self else {return}
            if self.text?.count == 0 {
                self.currentState = .isPlaceHolder
            }
        }.disposed(by: self.disposeBag)

        self.rx.text.subscribe {[weak self] (_) in
            guard let self = self else {return}
            if self.text.localized() == self.placeHolder.localized(){
                self.currentState = .isPlaceHolder
            }
            else if self.text.isEmpty && self.isFirstResponder {
                self.currentState = .isEmpty
            }
            else if self.text.isEmpty && !self.isFirstResponder {
                self.currentState = .isPlaceHolder
            }
            else{
                self.currentState = .isText
            }
            
        }.disposed(by: disposeBag)

    }
    
    private func handleUI(isPlaceHolder:Bool = true){
        self.textColor = isPlaceHolder ? DesignSystem.Colors.meduimGray.color:self.currnetTextColor
        self.borderColor = isPlaceHolder ? DesignSystem.Colors.meduimGray.color:DesignSystem.Colors.primary.color
        self.text = isPlaceHolder ? self.placeHolder.localized():self.text
    }
    
}

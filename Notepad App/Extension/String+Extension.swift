//
//  String+.swift


import UIKit

extension String {
    
    public var replacedArabicDigitsWithEnglish: String{
        var str = self
        let map = ["٠":"0",
                   "١":"1",
                   "٢":"2",
                   "٣":"3",
                   "٤":"4",
                   "٥":"5",
                   "٦":"6",
                   "٧":"7",
                   "٨":"8",
                   "٩":"9",
                   "٫":"."]
        map.forEach {
            str = str.replacingOccurrences(of: $0, with: $1)
        }
        return str
    }
    
    func localized(comment: String = "")-> String {
        var result: String
        
        let languageCode = LanguageManager.sharedInstance.currentLanguage()
        
        var path = Bundle.main.path(forResource: languageCode.rawValue, ofType: "lproj")
        
        if path == nil, let hyphenRange = languageCode.rawValue.range(of: "-") {
            let languageCodeShort = String(languageCode.rawValue[..<hyphenRange.lowerBound])
            path = Bundle.main.path(forResource: languageCodeShort, ofType: "lproj")
        }
        if let path = path, let locBundle = Bundle(path: path) {
            result = locBundle.localizedString(forKey: self, value: nil, table: nil)
        } else if languageCode != .en{
            result = NSLocalizedString(self, comment: comment)
        }else {
            result = self
        }
        return result
    }
    
    public var trimo: String {
        let newStr = self.replacingOccurrences(of: "ß", with: " ", options: .regularExpression).trimmingCharacters(in: .whitespacesAndNewlines)
        return newStr
    }

    func width(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func strikeThrough() -> NSAttributedString {
            let attributeString =  NSMutableAttributedString(string: self)
            attributeString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                   value: NSUnderlineStyle.single.rawValue,
                       range:NSMakeRange(0,attributeString.length))
            return attributeString
        }
    func convertTo(format outputFormat:String = "dd/MM/yyyy - HH:mm a", inputFormat:String = "yyyy-MM-dd'T'HH:mm:ss.SSS",localIdentifier:String = "en_US_POSIX" )->String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localIdentifier)
        dateFormatter.dateFormat = inputFormat
        
        guard  let date = dateFormatter.date(from: self)  else {
            return ""
        }
        
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
    func convertToDate(format:String = "h:mm a",localIdentifer:String = Language.en.rawValue) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: localIdentifer)
////
        if LanguageManager.sharedInstance.isRTL() {
            guard let date = dateFormatter.date(from: self)  else {return nil}
            dateFormatter.locale = Locale(identifier: Language.ar.rawValue)
            let dateStr = dateFormatter.string(from: date)
            return dateFormatter.date(from: dateStr)
        }
        
        return dateFormatter.date(from: self)
    }
}

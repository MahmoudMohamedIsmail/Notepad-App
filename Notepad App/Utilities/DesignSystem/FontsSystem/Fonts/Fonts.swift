//
//  Fonts.swift

import Foundation

enum Fonts: String{
    case light = "Poppins-Light"
    case regular = "Poppins-Regular"
    case medium = "Poppins-Medium"
    case semibold = "Poppins-SemiBold"
    case bold = "Poppins-Bold"
    case Black = "Poppins-Black"

    var name: String{
        return self.rawValue
    }
}

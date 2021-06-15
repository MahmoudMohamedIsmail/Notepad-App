//
//  Constant.swift

import Foundation
import UIKit

struct Constants{
    static let baseURL = ""
    static let deviceId = UIDevice.current.identifierForVendor?.uuidString
    static let appURL = ""
    static let GMSAPIKey = "AIzaSyC4YxVyGdQrE4ekLk48uE_HpCheenuM5cM"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
}

enum ContentType: String {
    case json = "application/x-www-form-urlencoded; charset=utf-8"
    case applicationJson = "application/json"
    case accept = "*/*"
    case acceptEncoding = "gzip;q=1.0, compress;q=0.5"
    case multipart = "multipart/form-data"
}
enum DateFormats:String {
    case mm_dd_yyyy = "MM-dd-yyyy"
}


enum Languages: String, CaseIterable {
    case en =  "89345AFF-2AB2-41DF-A1A1-708902799C67"
    case ar = "F9E168C0-13B3-4A64-92F0-2D65F83BAD19"
    
    var str: String!{
        switch self{
        case .en:
            return "English"
        case .ar:
            return "العربية"
        }
    }
}

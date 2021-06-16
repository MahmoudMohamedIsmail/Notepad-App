//
//  Note.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/16/21.
//

import RealmSwift
//import CoreLocation

class Note: Object {
    @objc dynamic var title = ""
    @objc dynamic var body = ""    
    @objc dynamic var photoData:Data? = nil
    @objc dynamic var long = ""
    @objc dynamic var lat = ""
    
    
}

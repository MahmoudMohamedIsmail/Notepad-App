//
//  RealmManager.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/16/21.
//

import RxRealm
import RealmSwift
import RxSwift

protocol NotesReposiotry {
    func getResults<T:Object>(object:T.Type) -> Observable<Results<T>>
    func addResult<T:Object>(object:T) -> Bool
    func removeResult<T:Object>(object:T) -> Bool
    func editResult<T:Object>(object:T, with finalObject:Note) -> Bool
}

class RealmManager:NotesReposiotry {
    
    
    static let shared = RealmManager()
    private lazy var disposeBag: DisposeBag = .init()
    private let realm = try! Realm()
    
    func getResults<T:Object>(object:T.Type) -> Observable<Results<T>>{
        let results = realm.objects(T.self)
        return Observable.collection(from: results)
    }
    
    func addResult<T:Object>(object: T) -> Bool {
        try! realm.write {
            realm.add(object)
        }
        return true
    }
    
    func removeResult<T:Object>(object: T) -> Bool{
        try! realm.write {
            realm.delete(object)
        }
        return true
    }
    
    func editResult<T:Object>(object:T, with finalObject:Note) -> Bool {
        guard let object = object as? Note else
        {return false}
        try! realm.write {
            object.title = finalObject.title
            object.body = finalObject.body
            object.photoData = finalObject.photoData
            object.lat = finalObject.lat
            object.long = finalObject.long
        }
        return true
    }
}


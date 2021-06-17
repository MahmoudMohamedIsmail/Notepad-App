//
//  NotesViewModel.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/13/21.
//

import RxRelay
import RxRealm
import RealmSwift
import RxSwift
import CoreLocation

protocol NotesViewModelInput {
    func delete(note:Note)
    func viewWillAppear()
}
protocol NotesViewModleOutput {
    var notesObservable:Observable<[Note]>{get}
    var isEmptyList:Observable<Bool>{get}
    var isNearestNote:Bool{get set}
}
class NotesViewModel: BaseViewModel, NotesViewModelInput, NotesViewModleOutput {
    
    var inputs:NotesViewModelInput{return self}
    var outputs:NotesViewModleOutput{return self}
    
    var deletedSuccessfully: PublishSubject<Bool> = .init()
    
    var closestLocation: CLLocation?
    var smallestDistance: CLLocationDistance?
    var isNearestNote: Bool = false
    
    
    private var notes:PublishSubject<[Note]> = .init()
    var notesObservable: Observable<[Note]> {
        return notes.asObservable()
    }
    
    var isEmptyList: Observable<Bool>{
        return notes.asObservable().map{$0.isEmpty}
    }
    
    
    
    override init() {
        super.init()
//        getAllNotes()
    }
    
    func viewWillAppear() {
        getAllNotes()
    }
    
    /*
     get current location and arrange notes, first note is nearest to my location and other sorted by date
     **/
    private func getAllNotes(){
        self.shouldShowProgress.onNext(true)
        LocationManager.shared.getCurrentLocation()
        LocationManager.shared.locationObservable.subscribe(onNext: { [weak self](currentLocation) in
            guard let self = self else {return}
            RealmManager.shared.getResults(object: Note.self).subscribe(onNext: {[weak self] (remotNotes) in
                guard let self = self else {return}
                self.shouldShowProgress.onNext(false)
                self.notes.onNext(remotNotes.toArray())
                let locations =  remotNotes.toArray().compactMap {CLLocation(latitude: $0.lat.value ?? 0, longitude: $0.long.value ?? 0)}.filter{$0.coordinate.latitude != 0 && $0.coordinate.longitude != 0}
//              
                let nearestLocation = LocationManager.shared.nearestLocation(locations: locations, closestToLocation: currentLocation)
              
                guard let nearest = nearestLocation, nearest.coordinate.latitude != 0, nearest.coordinate.longitude != 0 else {return}
                var notesarr = remotNotes.toArray()
                let nearestNode = notesarr.first {$0.lat.value == nearest.coordinate.latitude && $0.long.value == nearest.coordinate.longitude}
                notesarr.removeAll {$0.lat.value == nearest.coordinate.latitude && $0.long.value == nearest.coordinate.longitude}
                if let nearestNote = nearestNode {
                    notesarr.insert(nearestNote , at: 0)
                    self.isNearestNote = true
                }
                
                self.notes.onNext(notesarr)
            }).disposed(by: self.disposeBag)
        }).disposed(by: self.disposeBag)
    }
   
    func delete(note: Note) {
        if RealmManager.shared.removeResult(object: note){
            getAllNotes()
            self.showMessageObservable.onNext((nil, "Note deleted successfully".localized()))
        }
    }
    
}

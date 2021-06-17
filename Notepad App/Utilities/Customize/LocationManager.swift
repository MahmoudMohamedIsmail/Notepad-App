//
//  LocationManager.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/16/21.
//


import CoreLocation
import RxSwift

class LocationManager: NSObject {
    
    static var shared: LocationManager = LocationManager()
    
    var locationObservable: PublishSubject<CLLocation> = .init()
    private var manager: CLLocationManager = CLLocationManager()
    
    private override init() {
        
    }
    
    func getCurrentLocation() {
        
        guard CLLocationManager.locationServicesEnabled() else{
            self.navigateToAppSettings()
            return
        }
        
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.manager.distanceFilter = kCLLocationAccuracyKilometer
        self.manager.requestWhenInUseAuthorization()
        self.manager.requestLocation()
    }
    
    private func navigateToAppSettings(){
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    func nearestLocation(locations: [CLLocation], closestToLocation location: CLLocation) -> CLLocation? {
      if locations.count == 0 {
        return nil
      }

      var closestLocation: CLLocation?
      var smallestDistance: CLLocationDistance?

      for location in locations {
        let distance = location.distance(from: location)
        if smallestDistance == nil || distance < smallestDistance! {
          closestLocation = location
          smallestDistance = distance
        }
      }

      print("closestLocation: \(closestLocation), distance: \(smallestDistance)")
        return closestLocation
        
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.locationObservable.onNext(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("The user has not chosen whether the app can use location services.")
            manager.requestAlwaysAuthorization()
        case .restricted:
            print("The app is not authorized to use location services.")
        case .denied:
            print("The user denied the use of location services for the app or they are disabled globally in Settings.")
            self.navigateToAppSettings()
        case .authorizedAlways:
            print("The user authorized the app to start location services at any time.")
        case .authorizedWhenInUse:
            print("The user authorized the app to start location services while it is in use.")
        @unknown default:
            break
        }
    }
    
}

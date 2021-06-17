//
//  CLLocation+Ext.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/16/21.
//

import CoreLocation
import MapKit

extension CLLocationCoordinate2D {
    
    func getAddress(address: @escaping (String)->()) {
        let loc: CLLocation = CLLocation(latitude:self.latitude, longitude: self.longitude)
        CLGeocoder().reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }

                        address(addressString)
                        print(addressString)
                  }
            })
        }
//
//    func parseAddress() -> String {
//        let placeMark = MKPlacemark(coordinate: self.coordinate)
//        print(placeMark,"dsfsdfsdfs")
//        // put a space between "4" and "Melrose Place"
//        let firstSpace = (placeMark.subThoroughfare != nil &&
//                            placeMark.thoroughfare != nil) ? " " : ""
//
//        // put a comma between street and city/state
//        let comma = (placeMark.subThoroughfare != nil || placeMark.thoroughfare != nil) &&
//                    (placeMark.subAdministrativeArea != nil || placeMark.administrativeArea != nil) ? ", " : ""
//
//        // put a space between "Washington" and "DC"
//        let secondSpace = (placeMark.subAdministrativeArea != nil &&
//                            placeMark.administrativeArea != nil) ? " " : ""
//
//        let addressLine = String(
//            format:"%@%@%@%@%@%@%@",
//            // street number
//            placeMark.subThoroughfare ?? "",
//            firstSpace,
//            // street name
//            placeMark.thoroughfare ?? "",
//            comma,
//            // city
//            placeMark.locality ?? "",
//            secondSpace,
//            // state
//            placeMark.administrativeArea ?? ""
//        )
//
//        return addressLine
//    }
//
//
// func getAddressName()  -> String {
//
//    var adressString : String = ""
//        CLGeocoder().reverseGeocodeLocation(self) { (placemark, error) in
//                if error != nil {
//                    print("Hay un error")
//                } else {
//                    print(placemark,"placemark")
//
//                    let place = placemark! as [CLPlacemark]
//                    if place.count > 0 {
//                        let place = placemark![0]
//                        if place.thoroughfare != nil {
//                            adressString = adressString + place.thoroughfare! + ", "
//                        }
//                        if place.subThoroughfare != nil {
//                            adressString = adressString + place.subThoroughfare! + "\n"
//                        }
//                        if place.locality != nil {
//                            adressString = adressString + place.locality! + " - "
//                        }
//                        if place.postalCode != nil {
//                            adressString = adressString + place.postalCode! + "\n"
//                        }
//                        if place.subAdministrativeArea != nil {
//                            adressString = adressString + place.subAdministrativeArea! + " - "
//                        }
//                        if place.country != nil {
//                            adressString = adressString + place.country!
//                        }
//
//
//                    }
//                }
//            }
//            return adressString
//      }
//
}

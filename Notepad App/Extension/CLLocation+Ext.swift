//
//  CLLocation+Ext.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/16/21.
//

import CoreLocation
import MapKit

extension CLLocation{
  
 func getAddressName()  -> String {
    var adressString : String = ""
        CLGeocoder().reverseGeocodeLocation(self) { (placemark, error) in
                if error != nil {
                    print("Hay un error")
                } else {

                    let place = placemark! as [CLPlacemark]
                    if place.count > 0 {
                        let place = placemark![0]
                        if place.thoroughfare != nil {
                            adressString = adressString + place.thoroughfare! + ", "
                        }
                        if place.subThoroughfare != nil {
                            adressString = adressString + place.subThoroughfare! + "\n"
                        }
                        if place.locality != nil {
                            adressString = adressString + place.locality! + " - "
                        }
                        if place.postalCode != nil {
                            adressString = adressString + place.postalCode! + "\n"
                        }
                        if place.subAdministrativeArea != nil {
                            adressString = adressString + place.subAdministrativeArea! + " - "
                        }
                        if place.country != nil {
                            adressString = adressString + place.country!
                        }

                      
                    }
                }
            }
            return adressString
      }
    
}

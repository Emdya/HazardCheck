//
//  GeolocationAPI.swift
//  HazardCheck5.0
//
//  Created by Emdya P on 10/6/24.
//


//
//  GeolocationAPI.swift
//  HazardCheck5.0
//
//  Created by Emdya P on 10/6/24.
//

import Foundation
import CoreLocation

class GeolocationAPI: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var completion: ((CLLocationCoordinate2D?) -> Void)?
    
    func getCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        self.completion = completion
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            completion?(location)
        } else {
            completion?(nil)
        }
        locationManager.stopUpdatingLocation() // Stop updating to save battery life
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        completion?(nil)
    }
}

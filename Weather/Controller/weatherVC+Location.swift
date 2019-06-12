//
//  weatherVC+Location.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/29/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import CoreLocation
import UIKit

extension weatherVC: CLLocationManagerDelegate {
    
    // 1. Set the delegate to our VC
    // 2. Call requestLocation (only works once)
    // 3. Handle location authorization changes (denied, restricted, authorized, notDetermined)
    //    notDetermined is only called once (permissions popup) to ask for location. If denied,
    //    you will have to handle the popup on your own to ask for location permission by asking the
    //    user to go to Settings to change it.
    // 4. In the delegate's didUpdateLocation method, you will get your current location back every second
    //    You can do checks to make sure you are not getting back a cached location or an old one (optional)
    // 5. To get your location once, call requestLocation on the manager
    
    // check if the user denied the location popup
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            isLocationEnabled = true
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            isLocationEnabled = false
        case .notDetermined:
            isLocationEnabled = false
        @unknown default:
            break
        }
    }
    
    // Constantly spits out locations every second
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Horizontal accuracy (meters)
        let isAccurateLocation = location.horizontalAccuracy < 20 && location.horizontalAccuracy > 0
        //let lat = location.coordinate.latitude
        //let lon = location.coordinate.longitude
        if isAccurateLocation {
            if currentLocation == nil {
                loadWeather(location: location)
            }
            currentLocation = location
            
        }
    }
}

extension weatherVC {
    
    // #1
    func setupManager(vc: CLLocationManagerDelegate) {
        // set the delegate
        locationManager.delegate = vc
        
        // if the request fails, we can ask the user to open Settings
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // request the location (notDetermined), will continuoulsy return location
            locationManager.requestWhenInUseAuthorization()
        case .denied,.restricted:
            openSettings(vc: self)
        case .authorizedAlways,.authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    
    func openSettings(vc: UIViewController) {
        // Create a popup that asks user to go to Settings -> open url to Settings App
        let alert = UIAlertController(title: "Enable Location", message: "Please turn on location services in Settings to get the weather.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settings = UIAlertAction(title: "Settings", style: .default) { (action) in
            // go to settings
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(cancel)
        alert.addAction(settings)
        vc.present(alert, animated: true, completion: nil)
    }
}








//            if let currently = json["currently"] as? JSONDict,
//                let summary = currently["summary"] as? String {
//                print(summary)
//            }
//            if let hourly = json["hourly"] as? JSONDict,
//                let summary = hourly["summary"] as? String,
//                let data = hourly["data"] as? JSONArray {
//                print(summary)
//                print(data.count)
//            }
//            if let daily = json["daily"] as? JSONDict,
//                let summary = daily["summary"] as? String,
//                let data = daily["data"] as? JSONArray {
//                print(summary)
//                print(data.count)
//            }

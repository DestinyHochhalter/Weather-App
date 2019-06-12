//
//  weatherVC+Load.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/29/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import UIKit
import CoreLocation

extension weatherVC {
    
    @objc func loadWeatherTapped() {
        guard let currentLocation = currentLocation else { return }
        loadWeather(location: currentLocation)
    }
    
    @objc func searchTapped() {
       cityLbl.isUserInteractionEnabled = true
    
    }
    
    // @objc is required for taps
    func loadWeather(location: CLLocation) {
        // if we have a current location, get the weather
        if isLocationEnabled {
            // add lat lng into url request
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            let weatherUrl = getWeatherUrl(lat: lat, lng: lng)
            print(weatherUrl)
            
            // Get JSON
            getJSON(urlStr: weatherUrl) { (json) in
                guard let json = json else { return }
                // Set up JSON weather object
                self.dailyWeather = DailyWeather(json: json)
                
                // Update the UI
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        } else {
            openSettings(vc: self)
        }
    }
    
    // (what you want to return) -> (block to handle returned thing)
    // () -> Void
    // JSON, api calls, etc.
    // <unepected non-void return value in void function>
    // Create a geocoder with your location, get placemark -> city & state
    func getCity(location: CLLocation, completion: @escaping ((String?) -> ())) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil,
                let placemarks = placemarks,
                let placemark = placemarks.first,
                let state = placemark.administrativeArea,
                let city = placemark.locality {
                completion("\(city), \(state)")
            } else {
                completion(nil)
            }
        }
    }
    
    func clearUI() {
        cityLbl.text = "..."
        summaryLbl.text = "..."
        temperatureLbl.text = "..."
    }
    
    func updateUI() {
        // Get my current location -> get the city and update the UI
        guard let currentLocation = currentLocation, isLocationEnabled else { return }
        // set city
        getCity(location: currentLocation) { (city) in
            DispatchQueue.main.async {
                if let city = city {
                    self.cityLbl.text = city
                } else {
                    self.cityLbl.text = "..."
                }
            }
        }
        
        if let dailyWeather = self.dailyWeather {
            // set the rest
            print(dailyWeather._daily[0]._temperature)
            summaryLbl.text = dailyWeather._current._summary
            temperatureLbl.text = dailyWeather._current._temperature.toDegrees()
        }
        
        hourlyCollectionVw.reloadData()
        dailyTableVw.reloadData()
    }
}

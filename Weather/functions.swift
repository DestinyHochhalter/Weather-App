//
//  functions.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/28/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import UIKit

func getJSON(urlStr: String, completion: @escaping ([String: Any]?) -> ()) {
    if let url = URL(string: urlStr) {
        // 1. create session with no storing cookies, etc. Pass url into session.
        // 2. get data back from session and turn data into json [String:Any]
        URLSession(configuration: .ephemeral).dataTask(with: url) { (data, _, error) in
            if error == nil, let data = data {
                // no error getting data -> get json [String:Any]
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                        completion(json)
                    } else {
                        completion(nil)
                    }
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
            }.resume()
    } else {
        completion(nil)
    }
}

func getWeatherUrl(lat: Double, lng: Double) -> String {
    return "\(Constants.API.BaseUrl)\(Constants.API.Key)/\(lat),\(lng)"
}


extension Double {
    func toDegrees() -> String {
        return " \(Int(self))°"
    }
}

func getHour(unix: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: unix)
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

func getDay(unix: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: unix)
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter.string(from: date)
}


func setIcon(data: WeatherData, imgVw: UIImageView) {
    switch (data._icon) {
    case "clear-night":
        imgVw.image = UIImage(named: "clear-night")
    case "clear-day":
        imgVw.image = UIImage(named: "clear-day")
    case "partly-cloudy-day":
        imgVw.image = UIImage(named: "partly_cloudy_day")
    case "partly-cloudy-night":
        imgVw.image = UIImage(named: "partly-cloudy-night")
    case "cloudy":
        imgVw.image = UIImage(named: "cloudy")
    case "rain":
        imgVw.image = UIImage(named: "rain")
    case "fog":
        imgVw.image = UIImage(named: "fog")
    case "snow":
        imgVw.image = UIImage(named: "snow")
    default:
        break
    }
}


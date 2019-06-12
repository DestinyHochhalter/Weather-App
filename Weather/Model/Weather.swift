//
//  Weather.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/28/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import Foundation

class DailyWeather {
    var _current = WeatherData(json: [:])
    var _hourly = [WeatherData]()
    var _daily = [DayWeatherData]()
    
    init(json: JSONDict) {
        // get currently
        if let currently = json["currently"] as? JSONDict {
            self._current = WeatherData(json: currently)
        }
        // get hourly -> data
        if let hourly = json["hourly"] as? JSONDict,
            let data = hourly["data"] as? JSONArray {
            for d in data {
                self._hourly.append(WeatherData(json: d))
            }
        }
        // get daily -> data
        if let daily = json["daily"] as? JSONDict,
            let data = daily["data"] as? JSONArray {
            for d in data {
                self._daily.append(DayWeatherData(json: d))
            }
        }
    }
}

class WeatherData {
    
    var _temperature: Double = 0.0
    var _precipProbability: Double = 0.0
    var _summary: String = ""
    var _icon: String = ""
    var _apparentTemperature: Double = 0.0
    var _time: Int = 0
    
    init(json: [String:Any]) {
        if let temperature = json["temperature"] as? Double {
            self._temperature = temperature
        }
        if let precipProbability = json["precipProbability"] as? Double {
            self._precipProbability = precipProbability
        }
        if let summary = json["summary"] as? String {
            self._summary = summary
        }
        if let icon = json["icon"] as? String {
            self._icon = icon
        }
        if let apparentTemperature = json["apparentTemperature"] as? Double {
            self._apparentTemperature = apparentTemperature
        }
        if let time = json["time"] as? Int {
            self._time = time
        }
    }
}

class DayWeatherData: WeatherData {
    var _temperatureHigh: Double = 0.0
    var _temperatureLow: Double = 0.0
    var _apparentTemperatureHigh: Double = 0.0
    var _apparentTemperatureLow: Double = 0.0
    
    override init(json: [String:Any]) {
        if let apparentTemperatureHigh = json["apparentTemperatureHigh"] as? Double {
            self._apparentTemperatureHigh = apparentTemperatureHigh
        }
        if let apparentTemperatureLow = json["apparentTemperatureLow"] as? Double {
            self._apparentTemperatureLow = apparentTemperatureLow
        }
        if let temperatureHigh = json["temperatureHigh"] as? Double {
            self._temperatureHigh = temperatureHigh
        }
        if let temperatureLow = json["temperatureLow"] as? Double {
            self._temperatureLow = temperatureLow
        }
        super.init(json: json)
    }
}





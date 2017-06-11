//
//  ForecastViewModel.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

struct ForecastViewModel {
    
    let date: String
    let temperature: String
    let pressure: String
    let wind: String
    let icon: String
    let summary: String

    init(date:Date, icon: String, summary: String, temperature: Double, pressure: Double, wind:(speed: Double, direction: Double)) {
        
        // Note that the JSON weather API does not return descriptions for wind direction and speed,
        // so I have created enumerations for them.

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        
        self.date = dateFormatter.string(from:date)
        self.icon = icon
        self.summary = summary
        self.temperature = String(format:"%.1f°C",temperature)
        self.pressure = String(Int(pressure)) + "hpa"
        self.wind = Beaufort.fromSpeed(wind.speed).description + String(format:" (%.1fm/s, %@)",wind.speed, Cardinal.fromDirection(wind.direction).description)
    }
}

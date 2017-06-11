//
//  ForecastEntity.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

struct ForecastEntity {
    
    let date: Date!
    let icon: String!
    let summary: String!
    let temperature: Double!
    let pressure: Double!
    let wind: (speed: Double, direction: Double)
}

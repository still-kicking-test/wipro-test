
//
//  ForecastViewInput.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

protocol ForecastViewInput : class {
    
    func onDataDidChange(locationName: String)
}

//
//  ForecastPresenterInput.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

protocol ForecastPresenterInput {
    
    func onViewIsReady()
    func forecastCount() -> Int
    func forecastAtIndex(_ index: Int) -> ForecastViewModel?
}

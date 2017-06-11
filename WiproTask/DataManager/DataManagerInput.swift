//
//  DataManagerInput.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

protocol DataManagerInput {

    func loadForecast(cityId: Int, completion: @escaping ([ForecastEntity]) -> Void)
}

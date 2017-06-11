//
//  ForecastPresenter.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

class ForecastPresenter {
    
    weak var view:  ForecastViewInput!
    var dataManager: DataManager!
    
    var cityId = 2643743
    var cityName = "London"
    
    fileprivate var forecast:[ForecastEntity] = []
    
    func loadForecast(_ cityID: Int) {
        
        dataManager.loadForecast(cityId: cityId, completion: { (forecast : [ForecastEntity]) -> Void in
            
            DispatchQueue.main.async {
                self.onForecastDidLoadSuccess(forecast)
            }
        })
    }
}

extension ForecastPresenter : ForecastPresenterInput {
    
    func onViewIsReady() {
        
        loadForecast(cityId)
    }
    
    func forecastCount() -> Int {
        
        return forecast.count
    }
    
    func forecastAtIndex(_ index: Int) -> ForecastViewModel? {
    
        guard index < forecast.count else {return nil}
        
        let forecastEntity = forecast[index]
        return ForecastViewModel(date:forecastEntity.date, icon:forecastEntity.icon, summary: forecastEntity.summary, temperature:forecastEntity.temperature, pressure:forecastEntity.pressure, wind:forecastEntity.wind)
    }
}


extension ForecastPresenter : DataManagerOutput {
    
    func onForecastDidLoadSuccess(_ forecast: [ForecastEntity]) {
        
        self.forecast = forecast
        view.onDataDidChange(locationName: cityName)
    }
    
    func onForecastDidLoadFailure() {

    }
}

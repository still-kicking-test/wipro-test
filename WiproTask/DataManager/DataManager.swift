//
//  DataManager.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case general(String)
    case missing(String)
    case invalid(String, Any)
}

class RemoteDataManagerConstants {
    
    //  These could be injected for more flexibility...
    static let apiBaseURL = "http://api.openweathermap.org"
    static let apiVersion = "2.5"
    static let apiAppId = "19a1536f364f3b9f95be6e6cf29086b7"
}


class DataManager {

    func errorHandler(e:Error) {
        
    }

    func parseSpotForecast(cityId: Int, json: [String: Any]) throws -> ForecastEntity {
        
        // Extract date
        guard let binaryDate = json["dt"] as? Double else {
            throw SerializationError.missing("dt")
        }
        
        // Extract wind
        guard let jsonWind = json["wind"] as? [String: Double],
            let speed = jsonWind["speed"],
            let direction = jsonWind["deg"]
            else {
                throw SerializationError.missing("wind")
        }
        
        // Extract 'main'
        guard let jsonMain = json["main"] as? [String: Double],
            let temperature = jsonMain["temp"],
            let pressure = jsonMain["pressure"]
            else {
                throw SerializationError.missing("main")
        }

        // Extract 'weather'
        guard let jsonWeatherList = json["weather"] as? [[String:Any]] else {throw SerializationError.missing("weather")}
        
        // The API defines this element as an array, but it is not obvious why that should be the case. I ignore all but the last element (which
        // in reality seems to be the only element, it must be said)...
        var icon = ""
        var summary = ""
        for case let jsonWeather in jsonWeatherList as [[String:Any]] {
            icon = jsonWeather["icon"] as! String
            summary = jsonWeather["description"] as! String
        }
        
        
        let date = Date(timeIntervalSince1970: binaryDate)
        
        // Validate wind
        let wind = (speed, direction)
        guard case (0...200, 0...360) = wind else {
            throw SerializationError.invalid("wind", wind)
        }
        
        return ForecastEntity(date:date,
                              icon:icon,
                              summary:summary,
                              temperature: temperature - 273.15, // convert from (default) Kelvin to Celsius
                              pressure: pressure,
                              wind:wind)
    }
}

extension DataManager : DataManagerInput {
    
    func loadForecast(cityId: Int, completion: @escaping ([ForecastEntity]) -> Void) {
     
        var searchURLComponents = URLComponents(string: RemoteDataManagerConstants.apiBaseURL)!
        searchURLComponents.path = "/data/" + RemoteDataManagerConstants.apiVersion + "/forecast"
        searchURLComponents.queryItems = [URLQueryItem(name: "APPID", value: RemoteDataManagerConstants.apiAppId),
                                          URLQueryItem(name: "mode", value: "json"),
                                          URLQueryItem(name: "id", value: String(cityId))]
        let dataRequest = URLRequest(url: searchURLComponents.url!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: dataRequest, completionHandler: { (data, response, error) in
            
            if let e = error {
                print(e)
            }
            else {
                var forecast: [ForecastEntity] = []
                
                do {
                    guard let jsonFullResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else { throw SerializationError.general("no data returned") }
                    
                    if let jsonForecastList = jsonFullResponse["list"] {
                        
                        for case let jsonForecast in jsonForecastList as! [Any] {
                            let spotForecast = try self.parseSpotForecast(cityId: cityId, json: jsonForecast as! [String:Any])
                            forecast.append(spotForecast)
                        }
                    }
                    completion(forecast)
                }
                catch (SerializationError.missing(let s)) {print("JSON parse error, missing \(s)")}
                catch (SerializationError.invalid(let s, let v)) {print("JSON parse error, invalid \(s), value: \(v)")}
                catch {print(error)}
            }
        })
        task.resume()
    }
}

//
//  Utility.swift
//  WeatherForecast
//
//  Created by Vipul on 25/08/21.
//

import Foundation

var API_KEY = "fae7190d7e6433ec3a45285ffcf55c86"
var Wheather_Unit = "metric"
var Wheather_Duration = 1

class Utill: NSObject {
    static let shared = Utill()
    
    func getBookMarkedCities()-> [String] {
        if let arrayData = UserDefaults.standard.value(forKey: "BookMarkedCities") as? [String]{
            return arrayData
        }
        return [String]()
    }
    
    func bookeMarkedCities(arrCities: [String]) {
        var arrayPreviousCities = self.getBookMarkedCities()
        arrayPreviousCities.append(contentsOf: arrCities)
        UserDefaults.standard.setValue(arrayPreviousCities.uniqued(), forKey: "BookMarkedCities")
        UserDefaults.standard.synchronize()
    }
    
    func resetAllBookMarkedCities() {
        UserDefaults.standard.removeObject(forKey: "BookMarkedCities")
        UserDefaults.standard.synchronize()
    }
}

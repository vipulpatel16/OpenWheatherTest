//
//  AddCityViewModel.swift
//  WeatherForecast
//
//  Created by Vipul on 27/08/21.
//

import Foundation

class AddCityViewModel {
    
    var arraySelectedCities = [String]()
    var getDataSuccessfully: (() -> Void)?
    var cityWheather : ForeCastInfo?
    
}

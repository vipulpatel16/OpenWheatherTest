//
//  HomeViewModel.swift
//  WeatherForecast
//
//  Created by Vipul on 27/08/21.
//

import Foundation

class HomeViewModel {
    
    var arrayCities = [String]()
    var getDataSuccessfully: (() -> Void)?
    var cityWheather : ForeCastInfo?
    
    func getCities() {
        self.arrayCities.append(contentsOf: Utill.shared.getBookMarkedCities())
        self.getDataSuccessfully?()
    }
    
    func removeAllCities() {
        Utill.shared.resetAllBookMarkedCities()
        self.arrayCities.removeAll()
    }
    
    func deleteCity(indexToDelete: Int) {
        self.arrayCities.remove(at: indexToDelete)
        UserDefaults.standard.setValue(self.arrayCities, forKey: "BookMarkedCities")
        UserDefaults.standard.synchronize()
    }
    
}

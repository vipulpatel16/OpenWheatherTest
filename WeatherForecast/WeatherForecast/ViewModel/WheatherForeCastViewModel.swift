//
//  WheatherForeCastViewModel.swift
//  WeatherForecast
//
//  Created by Vipul on 25/08/21.
//

import Foundation

class WheatherForeCastViewModel {
    
    var getDataSuccessfully: (() -> Void)?
    var cityWheather : ForeCastInfo?
    var isGotForecastSuccessfully = false
    
    func getWheatherInfo(withCity: String)  {
        isGotForecastSuccessfully = false
        var jsonUrlString = ""
        if Wheather_Duration == 1 {
            jsonUrlString =
                "http://api.openweathermap.org/data/2.5/weather?q=\(withCity)&appid=\(API_KEY)&units=\(Wheather_Unit)"
        }else{
            jsonUrlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(withCity)&appid=\(API_KEY)&units=\(Wheather_Unit)"
        }
        
        
        guard let url = URL(string: jsonUrlString.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!) else{
                return
            }

            URLSession.shared.dataTask(with: url) { (data, res, err) in

                guard let data = data else {
                      return
                }
                    do {
                        let json = try JSONDecoder().decode(ForeCastInfo.self, from: data)
                        print(json)
                        self.cityWheather = json
                        self.isGotForecastSuccessfully = true
                        self.getDataSuccessfully?()
                    } catch {
                        print("didnt work")
                    }
        }.resume()
    }
}

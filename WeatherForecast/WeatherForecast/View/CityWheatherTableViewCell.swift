//
//  CityWheatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Vipul on 25/08/21.
//

import UIKit

class CityWheatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var labelTemp : UILabel!
    @IBOutlet weak var labelHumidity : UILabel!
    @IBOutlet weak var labelRain : UILabel!
    @IBOutlet weak var labelWind : UILabel!
    
    var setWheatherInfo: ForeCastInfo? {
        didSet{
            labelTemp.text = "\(setWheatherInfo?.main.temp ?? 0.0)"
            labelHumidity.text = "\(setWheatherInfo?.main.humidity ?? 0)"
            labelRain.text = "\(setWheatherInfo?.weather.first?.weatherDescription ?? "")"
            labelWind.text = "\(setWheatherInfo?.wind.speed ?? 0.0)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

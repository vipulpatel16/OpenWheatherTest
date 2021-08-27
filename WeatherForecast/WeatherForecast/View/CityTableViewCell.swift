//
//  CityTableViewCell.swift
//  WeatherForecast
//
//  Created by Vipul on 24/08/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var labelCity : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

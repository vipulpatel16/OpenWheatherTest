//
//  WheatherForecastViewController.swift
//  WeatherForecast
//
//  Created by Vipul on 25/08/21.
//

import UIKit

class WheatherForecastViewController: UIViewController {

    @IBOutlet weak var CityForeCastTableView : UITableView!
    var selectedCity = ""
    let viewModel = WheatherForeCastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCity
        // Do any additional setup after loading the view.
        prepareView()
    }
    
    private func prepareView() {
        CityForeCastTableView.tableFooterView = UIView()
        viewModel.getWheatherInfo(withCity: selectedCity)
        
        viewModel.getDataSuccessfully = {
            DispatchQueue.main.async {
                self.CityForeCastTableView.reloadData()
            }
        }
    }
}

extension WheatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellFromNIB(CityWheatherTableViewCell.self)
        cell.setWheatherInfo = viewModel.cityWheather
        return cell
    }
}

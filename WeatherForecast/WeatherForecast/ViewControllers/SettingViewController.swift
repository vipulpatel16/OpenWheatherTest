//
//  SettingViewController.swift
//  WeatherForecast
//
//  Created by Vipul on 25/08/21.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var metricButton : UIButton!
    @IBOutlet weak var imperialButton : UIButton!
    var cityRemoved : ((Bool)->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    private func prepareView() {
        if Wheather_Unit == "metric" {
            metricButton.isSelected = true
            imperialButton.isSelected = false
        }else{
            metricButton.isSelected = false
            imperialButton.isSelected = true
        }
    }
    
    @IBAction private func btnMetricClick() {
        Wheather_Unit = "metric"
        metricButton.isSelected = true
        imperialButton.isSelected = false
    }
    
    @IBAction private func btnImperialClick() {
        Wheather_Unit = "imperial"
        metricButton.isSelected = false
        imperialButton.isSelected = true
    }
    
    @IBAction private func btnResetBookMarkedCitiesClick() {
        let alert=UIAlertController(title:nil ,
                                    message: "Are you sure you want to reset bookmarked cities?",
                                    preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .default,
                                      handler: {action in
                                        Utill.shared.resetAllBookMarkedCities()
                                        self.cityRemoved?(true)
                                        self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

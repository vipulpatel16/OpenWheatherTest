//
//  HomeViewController.swift
//  WeatherForecast
//
//  Created by Vipul on 24/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var CityTableView : UITableView!
    
    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        // Do any additional setup after loading the view.
        prepareView()
    }
    
    private func prepareView() {
        let helpImage    = UIImage(named: "helpWhite")!
        let settingImage  = UIImage(named: "settings")!
        let helpButton   = UIBarButtonItem(image: helpImage,  style: .plain, target: self, action: #selector(didTapHelpButton(sender:)))
        let settingButton = UIBarButtonItem(image: settingImage,  style: .plain, target: self, action: #selector(didTapSettingButton(sender:)))
        navigationItem.rightBarButtonItems = [helpButton, settingButton]
        viewModel.getCities()
        viewModel.getDataSuccessfully = {
            DispatchQueue.main.async {
                self.CityTableView.reloadData()
            }
        }
    }
    
    @objc private func didTapHelpButton(sender: AnyObject){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc private func didTapSettingButton(sender: AnyObject){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController{
            vc.cityRemoved = { succcess in
                if succcess {
                    self.viewModel.removeAllCities()
                    self.CityTableView.reloadData()
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction private func addCity(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "AddCityViewController") as? AddCityViewController{
            vc.cityAdded = { succcess in
                if succcess {
                    self.viewModel.arrayCities.removeAll()
                    self.viewModel.getCities()
                    self.CityTableView.reloadData()
                }
            }
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellFromNIB(CityTableViewCell.self)
        cell.selectionStyle = .none
        cell.labelCity.text = self.viewModel.arrayCities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "WheatherForecastViewController") as? WheatherForecastViewController{
            vc.selectedCity = self.viewModel.arrayCities[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let alert=UIAlertController(title:nil ,
                                        message: "Are you sure you want to delete this city?",
                                        preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes",
                                          style: .default,
                                          handler: {action in
                                            self.viewModel.deleteCity(indexToDelete: indexPath.row)
                                            self.CityTableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "No",
                                          style: .default,
                                          handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}


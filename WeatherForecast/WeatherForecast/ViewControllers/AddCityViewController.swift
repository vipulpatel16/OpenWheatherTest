//
//  AddCityViewController.swift
//  WeatherForecast
//
//  Created by Vipul on 24/08/21.
//

import UIKit
import MapKit

class AddCityViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    var cityAdded : ((Bool)->())?
    
    let viewModel = AddCityViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Select City"
        PrepareView()
        addDoneButton()
    }
    
    private func addDoneButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onDoneClick))
    }
    
    @objc private func onDoneClick() {
        print("Done")
        Utill.shared.bookeMarkedCities(arrCities: viewModel.arraySelectedCities)
        self.dismiss(animated: true) {
            self.cityAdded?(true)
        }
    }
    
    private func PrepareView() {
//        let coordinate = CLLocationCoordinate2D(latitude: 23.0225, longitude: 72.5714)
//        let pinView = pinAnnotation(title: "Ahmedabad", subtitle: "iskon", coordinate: coordinate)
//        mapView.addAnnotation(pinView)
        mapView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func mapViewTapped(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        addPin(at: coordinate)
    }
    
    func addPin(at coordiante: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordiante.latitude, longitude: coordiante.longitude)
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)  // Rio de Janeiro, Brazil
            let newAnnotation = pinAnnotation(title: city, subtitle: country, coordinate: coordiante)
            self.mapView.addAnnotation(newAnnotation)
            self.viewModel.arraySelectedCities.append(city)
        }
    }
}

extension AddCityViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }

        let reuseId = "PinAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView?.isDraggable = true
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
}

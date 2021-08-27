//
//  PinAnnotation.swift
//  WeatherForecast
//
//  Created by Vipul on 24/08/21.
//

import Foundation
import MapKit

class pinAnnotation:NSObject,MKAnnotation {
    var title:String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var image: UIImage!
    init(title:String,subtitle:String,coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.image = UIImage.init(named: "mapPin")
    }
}

//
//  LightLocation.swift
//  Light up the night
//
//  Created by James Furlong on 4/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class LightLocation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    let luminosity: Int
    let id: String
    
    init(latitude: Double, longitude: Double, title: String? = nil, subtitle: String? = nil, luminosity: Int, id: String) {
        self.title = title
        self.subtitle = subtitle
        self.luminosity = luminosity
        self.id = id
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    }
}

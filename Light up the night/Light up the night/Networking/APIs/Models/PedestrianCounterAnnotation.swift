//
//  PedestrianCounterAnnotation.swift
//  Light up the night
//
//  Created by James Furlong on 3/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class PedestrianCounterAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationDescription: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationDescription: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationDescription = locationDescription
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationDescription
    }
}

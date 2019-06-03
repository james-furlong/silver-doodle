//
//  Location.swift
//  Light up the night
//
//  Created by James Furlong on 3/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class Location: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    let count: Int?
    
    init(latitude: Double, longitude: Double, title: String?, count: Int?) {
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = title
        self.count = count
    }
}

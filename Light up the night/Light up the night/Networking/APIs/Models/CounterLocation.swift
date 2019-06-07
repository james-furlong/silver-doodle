//
//  Location.swift
//  Light up the night
//
//  Created by James Furlong on 3/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class CounterLocation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var id: String
    var title: String?
    var subtitle: String?
    var count: Int?
    
    init(latitude: Double, longitude: Double, id: String, title: String?, count: Int?) {
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.id = id
        self.title = title
        self.count = count
    }
}

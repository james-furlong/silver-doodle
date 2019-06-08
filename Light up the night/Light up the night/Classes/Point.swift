//
//  Point.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class Point: NSObject, MKAnnotation {
    let groupId: DashboardButton
    let title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(groupId: DashboardButton, title: String?, subtitle: String?, latitude: Double, longitude: Double) {
        self.groupId = groupId
        self.title = title
        self.subtitle = subtitle
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

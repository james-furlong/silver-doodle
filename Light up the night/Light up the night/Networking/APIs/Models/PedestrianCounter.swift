//
//  PedestrianCounter.swift
//  Light up the night
//
//  Created by James Furlong on 3/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import MapKit

class PedestrianCounter {
    let id: Int
    let title: String?
    let status: String
    let date: Date
    let direction1: String?
    let direction1Count: Int
    let direction2: String?
    let direction2Count: Int
    let totalCount: Int
    let counterDescription: String
    let longitude: Double
    let latitude: Double
    let location: CounterLocation
    
    init(location: PedestrianCounterLocationResponseElement, counter: PedestrianCounterResponseElement) {
        self.id = Int(location.sensorID) ?? 0
        self.title = location.sensorName
        self.status = location.status
        self.date = {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd hh:mm:ss a"
            return df.date(from: counter.dateTime) ?? Date()
        }()
        self.direction1 = location.direction1
        self.direction1Count = Int(counter.direction1) ?? 0
        self.direction2 = location.direction2
        self.direction2Count = Int(counter.direction2) ?? 0
        self.totalCount = Int(counter.totalOfDirections) ?? 0
        self.counterDescription = location.sensorDescription
        self.longitude = Double(location.longitude) ?? 0.00
        self.latitude = Double(location.latitude) ?? 0.00
        self.location = CounterLocation(latitude: latitude, longitude: longitude, title: title, count: totalCount)
    }
    
    var subtitle: String? {
        return counterDescription
    }
}

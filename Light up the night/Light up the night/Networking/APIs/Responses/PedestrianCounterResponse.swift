//
//  PedestrianCounterResponse.swift
//  Light up the night
//
//  Created by James Furlong on 3/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

// MARK: - PedestrianCounterResponseElement
struct PedestrianCounterResponseElement: Codable {
    let date: String
    let time, sensorID, direction1, direction2: String
    let totalOfDirections, dateTime: String
    
    enum CodingKeys: String, CodingKey {
        case date, time
        case sensorID = "sensor_id"
        case direction1 = "direction_1"
        case direction2 = "direction_2"
        case totalOfDirections = "total_of_directions"
        case dateTime = "date_time"
    }
}

typealias PedestrianCounterResponse = [PedestrianCounterResponseElement]

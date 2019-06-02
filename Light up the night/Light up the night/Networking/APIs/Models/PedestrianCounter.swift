//
//  PedestrianCounterLocation.swift
//  Light up the night
//
//  Created by James Furlong on 2/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

// MARK: - Pedestrian Counter

struct PedestrianCounter: Codable {
    let sensorID, sensorDescription, sensorName, installationDate: String
    let direction2, direction1: String?
    let longitude, status, latitude: String
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case sensorID = "sensor_id"
        case sensorDescription = "sensor_description"
        case sensorName = "sensor_name"
        case installationDate = "installation_date"
        case status
        case direction1 = "direction_1"
        case direction2 = "direction_2"
        case latitude, longitude, location
    }
}

// MARK: - Location

struct Location: Codable {
    let latitude, longitude, humanAddress: String
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case humanAddress = "human_address"
    }
}

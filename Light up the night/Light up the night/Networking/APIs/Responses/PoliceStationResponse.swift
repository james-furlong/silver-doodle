//
//  PoliceStationResponse.swift
//  Light up the night
//
//  Created by James Furlong on 9/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct PoliceStationResponseElement: Codable {
    let id, name: String
    let theGeom: TheGeom
    let locDesc: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case theGeom = "the_geom"
        case locDesc = "loc_desc"
    }
}

typealias PoliceStationResponse = [PoliceStationResponseElement]

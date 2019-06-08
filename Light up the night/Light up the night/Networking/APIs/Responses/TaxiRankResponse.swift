//
//  TaxiRankResponse.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct TaxiRankResponseElement: Codable {
    let ref: String
    let safeCity: NightOnly
    let theGeom: TheGeom
    let locDesc, numSpaces: String
    let nightOnly: NightOnly
    
    enum CodingKeys: String, CodingKey {
        case ref
        case safeCity = "safe_city"
        case theGeom = "the_geom"
        case locDesc = "loc_desc"
        case numSpaces = "num_spaces"
        case nightOnly = "night_only"
    }
}

enum NightOnly: String, Codable {
    case no = "No"
    case yes = "Yes"
}

typealias TaxiRankResponse = [TaxiRankResponseElement]

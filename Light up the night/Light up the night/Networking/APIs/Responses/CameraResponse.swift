//
//  CameraResponse.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct CameraResponseElement: Codable {
    let ref: String
    let name: String
    let theGeom: TheGeom
    let locDesc: String
    
    enum CodingKeys: String, CodingKey {
        case ref
        case name = "name"
        case theGeom = "the_geom"
        case locDesc = "loc_desc"
    }
}

typealias CameraResponse = [CameraResponseElement]

//
//  StreetLightsResponse.swift
//  Light up the night
//
//  Created by James Furlong on 4/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

// MARK: - StreetLightingResponseElement
struct StreetLightingResponseElement: Codable {
    let theGeom: TheGeom
    let mccID, strID, extID, assetClas: String
    let assetType, assetSubt, name, label: String
    let profile, xdate, xsource: String
    let xorg: Xorg
    let xdrawing, propID, roadsegID, addresspt: String
    let addresspt1, easting, northing: String
    
    enum CodingKeys: String, CodingKey {
        case theGeom = "the_geom"
        case mccID = "mcc_id"
        case strID = "str_id"
        case extID = "ext_id"
        case assetClas = "asset_clas"
        case assetType = "asset_type"
        case assetSubt = "asset_subt"
        case name, label, profile, xdate, xsource, xorg, xdrawing
        case propID = "prop_id"
        case roadsegID = "roadseg_id"
        case addresspt = "addresspt_"
        case addresspt1, easting, northing
    }
}

// MARK: - TheGeom
struct TheGeom: Codable {
    let type: TypeEnum
    let coordinates: [Double]
}

enum TypeEnum: String, Codable {
    case point = "Point"
}

enum Xorg: String, Codable {
    case esg = "ESG"
}

typealias StreetLightingResponse = [StreetLightingResponseElement]

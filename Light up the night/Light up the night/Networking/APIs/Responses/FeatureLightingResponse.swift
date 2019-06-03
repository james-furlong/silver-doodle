//
//  FeatureLightingResponse.swift
//  Light up the night
//
//  Created by James Furlong on 4/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

// MARK: - FeatureLightingResponseElement
struct FeatureLightingResponseElement: Codable {
    let assetNumber, assetDescription: String
    let lampTypeLupvalue, lampRatingW: String?
    let mountingTypeLupvalue: MountingTypeLupvalue?
    let lat, lon: String
    let location: LocationResponse
    
    enum CodingKeys: String, CodingKey {
        case assetNumber = "asset_number"
        case assetDescription = "asset_description"
        case lampTypeLupvalue = "lamp_type_lupvalue"
        case lampRatingW = "lamp_rating_w"
        case mountingTypeLupvalue = "mounting_type_lupvalue"
        case lat, lon, location
    }
}

enum MountingTypeLupvalue: String, Codable {
    case bollard = "Bollard"
    case bridgeBeam = "Bridge Beam"
    case buildingEve = "Building Eve"
    case buildingFacade = "Building Facade"
    case canopy = "Canopy"
    case fender = "Fender"
    case guyWireCatenary = "Guy Wire (Catenary)"
    case inground = "Inground"
    case parapet = "Parapet"
    case pileMarine = "Pile (Marine)"
    case pole = "Pole"
    case poleMultipleFixed = "Pole: Multiple Fixed"
    case stairs = "Stairs"
    case tree = "Tree"
    case underSeat = "Under Seat"
    case wall = "Wall"
}

typealias FeatureLightingResponse = [FeatureLightingResponseElement]

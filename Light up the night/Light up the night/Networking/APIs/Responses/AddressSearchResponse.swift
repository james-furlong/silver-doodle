//
//  AddressSearchResponse.swift
//  Light up the night
//
//  Created by James Furlong on 9/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct AddressSearchResponseElement: Codable {
    let streetNo: String?
    let gisid: String
    let theGeom: TheGeom?
    let strName: String
    let suburb: String
    let addressPnt, suburbID, streetID, easting: String
    let northing, latitude, longitude: String
    let addComp: String?
    
    enum CodingKeys: String, CodingKey {
        case streetNo = "street_no"
        case gisid
        case theGeom = "the_geom"
        case strName = "str_name"
        case suburb
        case addressPnt = "address_pnt"
        case suburbID = "suburb_id"
        case streetID = "street_id"
        case easting, northing, latitude, longitude
        case addComp = "add_comp"
    }
}

typealias AddressSearchResponse = [AddressSearchResponseElement]

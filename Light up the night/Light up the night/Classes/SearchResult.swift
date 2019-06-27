//
//  File.swift
//  Light up the night
//
//  Created by James Furlong on 27/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct SearchResult {
    let streetExtra: String?
    let streetNumber: Int
    let streetName: String
    let suburb: String
    let state: String
    let postcode: Int
    let country: String
    
    var fullAddress: String {
        var address: String = ""
        if let extra = streetExtra {
            address = String.init(
                format: "%s, %s %s, %s %s, %s %s",
                extra,
                streetNumber,
                streetName,
                suburb,
                state,
                country,
                postcode
            )
        }
        else {
            address = String.init(
                format: "%s %s, %s %s, %s %s",
                streetNumber,
                streetName,
                suburb,
                state,
                country,
                postcode
            )
        }
        
        return address
    }
}

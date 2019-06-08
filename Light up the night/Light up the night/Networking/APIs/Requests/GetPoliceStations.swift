//
//  GetPoliceStations.swift
//  Light up the night
//
//  Created by James Furlong on 9/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct GetPoliceStations: APIEndpoint, Codable {
    
    func endpoint() -> String {
        return "Vic_police_locations"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: PoliceStationResponse) -> Void),
        onError errorHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)
        ) {
        APIRequest.readJson(
            fileName: self,
            onSuccess: successHandler,
            onError: errorHandler
        )
    }
}

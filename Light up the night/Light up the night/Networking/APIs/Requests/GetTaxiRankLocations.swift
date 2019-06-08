//
//  GetTaxiRankLocations.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct GetTaxiRankLocations: APIEndpoint, Codable {
    
    func endpoint() -> String {
        return "https://data.melbourne.vic.gov.au/resource/rtir-tspj.json"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: TaxiRankResponse) -> Void),
        onError errorHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)
        ) {
        APIRequest.get(
            request: self,
            onSuccess: successHandler,
            onError: errorHandler
        )
    }
}

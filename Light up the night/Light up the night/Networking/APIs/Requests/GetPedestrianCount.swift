//
//  GetPedestrianCount.swift
//  Light up the night
//
//  Created by James Furlong on 3/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct GetPedestrianCount: APIEndpoint, Codable {
    
    func endpoint() -> String {
        return "https://data.melbourne.vic.gov.au/resource/d6mv-s43h.json"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: PedestrianCounterResponse) -> Void),
        onError errorHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)
        ) {
        APIRequest.get(
            request: self,
            onSuccess: successHandler,
            onError: errorHandler)
    }
}

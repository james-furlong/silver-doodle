//
//  GetPedestrianCounterLocations.swift
//  Light up the night
//
//  Created by James Furlong on 2/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct GetPedestrianCounterLocations: APIEndpoint, Codable {
    
    func endpoint() -> String {
        return "https://data.melbourne.vic.gov.au/resource/h57g-5234.json"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: PedestrianCounterLocationResponse) -> Void),
        onFailure failureHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)
    ) {
        APIRequest.get(
            request: self,
            onSuccess: successHandler,
            onError: failureHandler
        )
        
    }
}

//
//  GetStreetLights.swift
//  Light up the night
//
//  Created by James Furlong on 4/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct GetStreetLights: APIEndpoint, Codable {
    
    /// Function to expose the endpoint to an external object
    ///
    /// - Returns: The string value of the endpoint
    func endpoint() -> String {
        return "https://data.melbourne.vic.gov.au/resource/5zzh-xdju.json$limit=5000"
    }
    
    /// Public function to retrieve the API and return the completion handler based on the API Result type
    ///
    /// - Parameters:
    ///   - successHandler: successful completion handler
    ///   - failureHandler: failure completion handler
    func dispatch(
        onSuccess successHandler: @escaping ((_: StreetLightingResponse) -> Void),
        onError errorHandler: @escaping((_: APIRequest.ErrorResponse?, _: Error) -> Void)
        ) {
        APIRequest.get(
            request: self,
            onSuccess: successHandler,
            onError: errorHandler)
    }
}

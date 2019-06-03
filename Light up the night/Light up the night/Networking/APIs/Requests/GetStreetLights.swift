//
//  GetStreetLights.swift
//  Light up the night
//
//  Created by James Furlong on 4/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct GetStreetLights: APIEndpoint, Codable {
    
    func endpoint() -> String {
        return "https://data.melbourne.vic.gov.au/resource/5zzh-xdju.json"
    }
    
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

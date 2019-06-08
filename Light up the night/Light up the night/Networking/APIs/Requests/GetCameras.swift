//
//  GetCameras.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct GetCameras: APIEndpoint, Codable {
    
    func endpoint() -> String {
        return "Safe_city_cameras"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: CameraResponse) -> Void),
        onError errorHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)
        ) {
        APIRequest.get(
            request: self,
            onSuccess: successHandler,
            onError: errorHandler
        )
    }
}


//struct GetTaxiRankLocations: APIEndpoint, Codable {
//
//    func endpoint() -> String {
//        return "https://data.melbourne.vic.gov.au/resource/rtir-tspj.json"
//    }
//
//    func dispatch(
//        onSuccess successHandler: @escaping ((_: TaxiRankResponse) -> Void),
//        onError errorHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)
//        ) {
//        APIRequest.get(
//            request: self,
//            onSuccess: successHandler,
//            onError: errorHandler
//        )
//    }
//}

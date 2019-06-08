//
//  ApiClient.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

//protocol ApiClientType {
//    var getPedestrianCounterLocations: PedestrianCounterLocationResponse? { get }
//    var getPedestrianCounter: PedestrianCounterResponse? { get }
//    var getFeatureLightLocations: [Point]? { get }
//    var getStreetLights: [Point]? { get }
//}
//
//struct ApiClient: ApiClientType {
//    
//    lazy var pedestrianCounterLocations: PedestrianCounterLocationResponse? = {
//        return getPedestrianCounterLocations()
//    }()
//    
//    func getPedestrianCounterLocations() -> PedestrianCounterLocationResponse? {
//        GetPedestrianCounterLocations()
//            .dispatch(
//                onSuccess: { successResponse in
//                    return successResponse
//            },
//                onFailure: { errorResponse, error in
//                    print("Counter Locations error: \(error.localizedDescription)")
//            }
//        )
//    }
//    
//    var getPedestrianCounter: PedestrianCounterResponse?
//    
//    var getFeatureLightLocations: [Point]?
//    
//    var getStreetLights: [Point]?
//}

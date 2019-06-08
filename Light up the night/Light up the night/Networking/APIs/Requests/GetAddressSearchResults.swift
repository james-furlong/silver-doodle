//
//  GetAddressSearchResults.swift
//  Light up the night
//
//  Created by James Furlong on 9/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

class GetAddressSearchResults: APIEndpoint, Codable {
    
    var query: String = ""
    
    func endpoint() -> String {
        return "https://data.melbourne.vic.gov.au/resource/imwx-szwr.json?\(query)"
    }
    
    func dispatch(
        searchQuery: String,
        onSuccess successHandler: @escaping ((_: AddressSearchResponse) -> Void),
        onError errorHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)
        ) {
        query = "$where=address_pnt like '%\(searchQuery)%"
        APIRequest.get(
            request: self,
            onSuccess: successHandler,
            onError: errorHandler
        )
    }
}

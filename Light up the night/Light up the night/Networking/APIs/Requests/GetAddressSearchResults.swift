//
//  GetAddressSearchResults.swift
//  Light up the night
//
//  Created by James Furlong on 9/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

struct GetAddressSearchResults: APIEndpoint, Codable {
    
    var query: String
    
    init(with query: String) {
        self.query = "$where=street_no like '54%' AND str_name like 'Rat%'"
    }
    
    func endpoint() -> String {
        return "https://data.melbourne.vic.gov.au/resource/imwx-szwr.json?\(query)"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: AddressSearchResponse) -> Void),
        onError errorHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)
        ) {
        APIRequest.get(
            request: self,
            onSuccess: successHandler,
            onError: errorHandler
        )
    }
}

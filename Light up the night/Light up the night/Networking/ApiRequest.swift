//
//  ApiRequest.swift
//  Light up the night
//
//  Created by James Furlong on 2/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

protocol ApiRequest: Encodable {
    associatedtype Response: Decodable
    
    var resourceName: String { get }
}

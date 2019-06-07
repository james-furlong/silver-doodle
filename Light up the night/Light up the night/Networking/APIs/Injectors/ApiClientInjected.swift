//
//  ApiClientInjected.swift
//  Light up the night
//
//  Created by James Furlong on 8/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

protocol ApiClientInjected {}

extension ApiClientInjected {
    var apiClient: ApiClient { return ApiClient() }
}

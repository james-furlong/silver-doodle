//
//  APIRequest.swift
//  Light up the night
//
//  Created by James Furlong on 2/6/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation

class APIRequest {
    
    struct ErrorResponse: Codable {
        let status: String
        let code: Int
        let message: String
    }
    
    enum APIError: Error {
        case invalidEndpoint
        case errorResponseDetected
        case noData
    }
}

extension APIRequest {
    
    public static func post<R: Codable & APIEndpoint, T: Codable, E: Codable>(
        request: R,
        onSuccess: @escaping ((_: T) -> Void),
        onError: @escaping ((_: E?, _: Error) -> Void)
        ) {
        
        guard var endpointRequest: URLRequest = self.urlRequest(from: request) else {
            onError(nil, APIError.invalidEndpoint)
            return
        }
        
        endpointRequest.httpMethod = "POST"
        endpointRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            endpointRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            onError(nil, error)
            return
        }
        
        URLSession.shared.dataTask(
            with: endpointRequest,
            completionHandler: { data, urlResponse, error in
                DispatchQueue.main.async {
                    self.processResponse(data, urlResponse, error, onSuccess: onSuccess, onError: onError)
                }
        }).resume()
    }
    
    public static func get<R: Codable & APIEndpoint, T: Codable, E: Codable> (
        request: R,
        onSuccess: @escaping ((_: T) -> Void),
        onError: @escaping ((_: E?, Error) -> Void)
        ) {
        
        guard let url: URL = URL(string: request.endpoint()) else {
            onError(nil, APIError.invalidEndpoint)
            return
        }
        
        URLSession.shared.dataTask(
            with: url,
            completionHandler: { data, urlResponse, error in
                DispatchQueue.main.async {
                    self.processResponse(data, urlResponse, error, onSuccess: onSuccess, onError: onError)
                }

        }).resume()
    }
    
    public static func readJson<R: Codable & APIEndpoint, T: Codable, E: Codable> (
        fileName: R,
        onSuccess: @escaping ((_: T) -> Void),
        onError: @escaping ((_: E?, Error) -> Void)
        ) {
        
        guard let name = fileName.endpoint() as? String else { return }
        
        if let url = Bundle.main.url(forResource: name, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                self.processResponse(data, nil, nil, onSuccess: onSuccess, onError: onError)
            } catch {
                print("Error on retrieving local json file: \(error.localizedDescription)")
            }
        }
    }
    
    public static func processResponse<T: Codable, E: Codable>(
        _ dataOrNil: Data?,
        _ urlResponseOrNil: URLResponse?,
        _ errorOrNil: Error?,
        onSuccess: ((_: T) -> Void),
        onError: ((_: E?, _: Error) -> Void)) {
        
        if let data = dataOrNil {
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                onSuccess(decodedResponse)
            } catch {
                let originalError = error
                
                do {
                    let errorResponse = try JSONDecoder().decode(E.self, from: data)
                    onError(errorResponse, APIError.errorResponseDetected)
                } catch {
                    onError(nil, originalError)
                }
            }
        } else {
            onError(nil, errorOrNil ?? APIError.noData)
        }
    }
    
    public static func urlRequest(from request: APIEndpoint) -> URLRequest? {
        let endpoint = request.endpoint()
        guard let endpointUrl = URL(string: endpoint) else {
            return nil
        }
        
        var endpointRequest = URLRequest(url: endpointUrl)
        endpointRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return endpointRequest
    }
}

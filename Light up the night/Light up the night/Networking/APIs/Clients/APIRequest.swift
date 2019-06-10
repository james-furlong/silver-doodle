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
    
    /// A generic function to POST data to an API
    ///
    /// - Parameters:
    ///   - request: The GET request that holds the API endpoint
    ///   - onSuccess: Success handler
    ///   - onError: Failure handler
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
    
    /// A generic function to call and recieve an API call
    ///
    /// - Parameters:
    ///   - request: The api request that holds the endpoint being hit
    ///   - onSuccess: Success handler
    ///   - onError: Failure handler
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
    
    /// A generic function to read a JSON file that has been save locally
    ///
    /// - Parameters:
    ///   - fileName: Name of the local JSON file (note: Do not include the extension)
    ///   - onSuccess: Success closure
    ///   - onError: Failure closure
    public static func readJson<R: Codable & APIEndpoint, T: Codable, E: Codable> (
        fileName: R,
        onSuccess: @escaping ((_: T) -> Void),
        onError: @escaping ((_: E?, Error) -> Void)
        ) {
        
        let name = fileName.endpoint()
        
        if let url = Bundle.main.url(forResource: name, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                self.processResponse(data, nil, nil, onSuccess: onSuccess, onError: onError)
            } catch {
                print("Error on retrieving local json file: \(error.localizedDescription)")
            }
        }
    }
    
    /// A generic function to process and decode JSON data
    ///
    /// - Parameters:
    ///   - dataOrNil: The data being decoded
    ///   - urlResponseOrNil: The response from the original API call
    ///   - errorOrNil: The error recieved if the API failed
    ///   - onSuccess: The success handler
    ///   - onError: The failure handler
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
    
    /// Function to transform the APIEndpoint type into a URLRequest
    ///
    /// - Parameter request: The APIEndpoint object to be transformed
    /// - Returns: The transformed URLReequest that can now be used to call an API
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

//
//  Endpoint.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
    var params: [String: Any]? { get }
    var method: HTTPMethod { get }
    
}

extension Endpoint {
    
    var apiKey: String {
        return "0141e6d543b187f0b7e6bb3a1902209a"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params, method == .get {
            queryItems.append(contentsOf: params.map {
                return URLQueryItem(name: "\($0)", value: "\($1)")
            })
        }
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let params = params, method == .post {
            request.httpBody = params.percentEscaped().data(using: .utf8)
        }
        return request
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

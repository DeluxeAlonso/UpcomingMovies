//
//  APIError.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum APIError: Error, Equatable {

    case notAuthenticated
    case notFound
    case networkProblem
    case badRequest
    case requestFailed
    case invalidData
    case unknown(HTTPURLResponse?)

    init(response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else {
            self = .unknown(nil)
            return
        }
        switch response.statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .notAuthenticated
        case 404:
            self = .notFound
        default:
            self = .unknown(response)
        }
    }

    var isAuthError: Bool {
        switch self {
        case .notAuthenticated: return true
        default: return false
        }
    }

}

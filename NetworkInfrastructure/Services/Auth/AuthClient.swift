//
//  AuthClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

class AuthClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getRequestToken(with readAccessToken: String, completion: @escaping (Result<RequestTokenResult, APIError>) -> Void) {
        fetch(with: AuthProvider.getRequestToken(readAccessToken: readAccessToken).request, decode: { json -> RequestTokenResult? in
            guard let requestToken = json as? RequestTokenResult else { return nil }
            return requestToken
        }, completion: completion)
    }

    func getAccessToken(with readAccessToken: String, requestToken: String, completion: @escaping (Result<AccessToken, APIError>) -> Void) {
        fetch(with: AuthProvider.getAccessToken(readAccessToken: readAccessToken,
                                                requestToken: requestToken).request, decode: { json -> AccessToken? in
            guard let requestToken = json as? AccessToken else { return nil }
            return requestToken
        }, completion: completion)
    }

    func createSessionId(with accessToken: String, completion: @escaping (Result<SessionResult, APIError>) -> Void) {
        fetch(with: AuthProvider.createSessionId(accessToken: accessToken).request, decode: { json -> SessionResult? in
            guard let sessionResult = json as? SessionResult else { return nil }
            return sessionResult
        }, completion: completion)
    }
    
}

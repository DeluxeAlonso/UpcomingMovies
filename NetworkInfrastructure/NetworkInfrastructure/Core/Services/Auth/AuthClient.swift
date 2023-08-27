//
//  AuthClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class AuthClient: APIClient, AuthClientProtocol {

    let session: URLSession

    // MARK: - Initializers

    init(session: URLSession) {
        self.session = session
    }

    convenience init() {
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        self.init(session: session)
    }

    // MARK: - AuthClientProtocol

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

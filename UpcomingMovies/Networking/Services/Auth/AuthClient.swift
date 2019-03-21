//
//  AuthenticationClient.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
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
    
    func getRequestToken(completion: @escaping (Result<RequestToken, APIError>) -> Void) {
        fetch(with: AuthProvider.getRequestToken.request, decode: { json -> RequestToken? in
            guard let requestToken = json as? RequestToken else { return nil }
            return requestToken
        }, completion: completion)
    }
    
}

//
//  AuthenticationManager.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import KeychainSwift

class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private lazy var keychain = KeychainSwift()
    
    func saveSessionId(_ sessionId: String) {
        keychain.set(sessionId, forKey: Constants.sessionIdKey)
    }
    
    func retrieveSessionId() -> String? {
        return keychain.get(Constants.sessionIdKey)
    }
    
    func deleteSessionId() {
        keychain.delete(Constants.sessionIdKey)
    }
    
    func isUserSignedIn() -> Bool {
        return retrieveSessionId() != nil
    }
    
}

extension AuthenticationManager {
    
    struct Constants {
        static let sessionIdKey = "UpcomingMoviesSessionId"
    }
    
}

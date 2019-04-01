//
//  UserClient.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

class UserClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getAccountDetail(_ context: NSManagedObjectContext,
                          with sessionId: String, completion: @escaping (Result<User, APIError>) -> Void) {
        fetch(with: UserProvider.getAccountDetail(sessionId: sessionId).request,
              context: context, decode: { json -> User? in
            guard let user = json as? User else { return  nil }
            return user
        }, completion: completion)
    }
    
}

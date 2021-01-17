//
//  GenreClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

class GenreClient: APIClient, GenreClientProtocol {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getAllGenres(completion: @escaping (Result<GenreResult, APIError>) -> Void) {
        fetch(with: GenreProvider.getAll.request, decode: { json -> GenreResult? in
            guard let genreFeedResult = json as? GenreResult else { return  nil }
            return genreFeedResult
        }, completion: completion)
    }
    
}

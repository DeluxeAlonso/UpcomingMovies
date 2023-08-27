//
//  GenreClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class GenreClient: APIClient, GenreClientProtocol {

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

    // MARK: - GenreClientProtocol

    func getAllGenres(completion: @escaping (Result<GenreResult, APIError>) -> Void) {
        fetch(with: GenreProvider.getAll.request, decode: { json -> GenreResult? in
            guard let genreFeedResult = json as? GenreResult else { return  nil }
            return genreFeedResult
        }, completion: completion)
    }

}

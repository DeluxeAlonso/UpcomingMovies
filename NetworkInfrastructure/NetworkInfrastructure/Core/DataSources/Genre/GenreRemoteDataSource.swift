//
//  GenreRemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain
import UpcomingMoviesData

final class GenreRemoteDataSource: GenreRemoteDataSourceProtocol {

    private let client: GenreClientProtocol

    init(client: GenreClientProtocol) {
        self.client = client
    }

    func getAllGenres(completion: @escaping (Result<[UpcomingMoviesDomain.Genre], Error>) -> Void) {
        client.getAllGenres(completion: { result in
            switch result {
            case .success(let genreResult):
                let genres = genreResult.genres.map { $0.asDomain() }
                completion(.success(genres))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

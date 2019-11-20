//
//  GenreRemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import UpcomingMoviesData

final class GenreRemoteDataSource: GenreRemoteDataSourceProtocol {
    
    private let client: GenreClient
    
    init(client: GenreClient) {
        self.client = client
    }
    
    func getAllGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        client.getAllGenres(completion: { result in
            switch result {
            case .success(let genreResult):
                completion(.success(genreResult.genres))
            case .failure(let error):
                completion(.failure(error))
                print(error.description)
            }
        })
    }
    
}

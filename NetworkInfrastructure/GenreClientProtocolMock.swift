//
//  GenreClientProtocolMock.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 20/09/23.
//

import UpcomingMoviesDomain

final class GenreClientProtocolMock: GenreClientProtocol {

    var getAllGenresResult: Result<GenreResult, APIError>?
    private(set) var getAllGenresCallCount = 0
    func getAllGenres(completion: @escaping (Result<GenreResult, APIError>) -> Void) {
        if let getAllGenresResult = getAllGenresResult {
            completion(getAllGenresResult)
        }
        getAllGenresCallCount += 1
    }

}

//
//  MovieSearchLocalDataSourceProtocolMock.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 24/06/22.
//

@testable import UpcomingMoviesDomain

final class MovieSearchLocalDataSourceProtocolMock: MovieSearchLocalDataSourceProtocol {

    var didUpdateMovieSearch: (() -> Void)?

    var getMovieSearchesResult: Result<[MovieSearch], Error>?
    private(set) var getMovieSearchesCallCount = 0
    func getMovieSearches(completion: @escaping (Result<[MovieSearch], Error>) -> Void) {
        if let getMovieSearchesResult = getMovieSearchesResult {
            completion(getMovieSearchesResult)
        }
        getMovieSearchesCallCount += 1
    }

    var saveResult: Result<Void, Error>?
    private(set) var saveCallCount = 0
    func save(with searchText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if let saveResult = saveResult {
            completion(saveResult)
        }
        saveCallCount += 1
    }

}

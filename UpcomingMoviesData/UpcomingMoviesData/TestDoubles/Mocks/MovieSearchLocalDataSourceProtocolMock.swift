//
//  MovieSearchLocalDataSourceProtocolMock.swift
//  UpcomingMoviesData-Unit-UpcomingMoviesDataTests
//
//  Created by Alonso on 24/06/22.
//

@testable import UpcomingMoviesDomain

final class MovieSearchLocalDataSourceProtocolMock: MovieSearchLocalDataSourceProtocol {

    var didUpdateMovieSearch: (() -> Void)?

    private (set) var getMovieSearchesCallCount = 0
    var foundMovieSearches: [MovieSearch] = []
    func getMovieSearches() -> [MovieSearch] {
        getMovieSearchesCallCount += 1
        return foundMovieSearches
    }

    private (set) var saveCallCount = 0
    func save(with searchText: String) {
        saveCallCount += 1
    }

}

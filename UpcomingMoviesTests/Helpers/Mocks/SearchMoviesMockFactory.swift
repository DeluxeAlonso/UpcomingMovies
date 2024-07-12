//
//  SearchMoviesMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class SearchOptionsInteractorMock: SearchOptionsInteractorProtocol {

    var didUpdateMovieVisit: (() -> Void)?

    var getGenresResult: Result<[GenreProtocol], Error>?
    private(set) var getGenresCallCount = 0
    func getGenres(completion: @escaping (Result<[GenreProtocol], Error>) -> Void) {
        if let getGenresResult = getGenresResult {
            completion(getGenresResult)
        }
        getGenresCallCount += 1
    }

    var getMovieVisitsResult: Result<[MovieVisit], Error>?
    private(set) var getMovieVisitsCallCount = 0
    func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void) {
        if let getMovieVisitsResult = getMovieVisitsResult {
            completion(getMovieVisitsResult)
        }
        getMovieVisitsCallCount += 1
    }

}

final class MockSearchMoviesResultControllerDelegate: MockViewController, SearchMoviesResultControllerDelegate {

    var didSelectRecentSearch = 0
    func searchMoviesResultController(_ searchMoviesResultController: SearchMoviesResultController, didSelectRecentSearch searchText: String) {
        didSelectRecentSearch += 1
    }

}

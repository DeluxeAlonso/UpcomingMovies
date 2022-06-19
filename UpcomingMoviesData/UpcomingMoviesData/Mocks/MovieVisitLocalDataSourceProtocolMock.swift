//
//  MovieVisitLocalDataSourceProtocolMock.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 18/06/22.
//

import Foundation
@testable import UpcomingMoviesDomain

final class MovieVisitLocalDataSourceProtocolMock: MovieVisitLocalDataSourceProtocol {

    var didUpdateMovieVisit: (() -> Void)?

    private (set) var getMovieVisitsCallCount = 0
    func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void) {
        getMovieVisitsCallCount += 1
    }

    private (set) var saveCallCount = 0
    func save(with id: Int, title: String, posterPath: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        saveCallCount += 1
    }
    
}

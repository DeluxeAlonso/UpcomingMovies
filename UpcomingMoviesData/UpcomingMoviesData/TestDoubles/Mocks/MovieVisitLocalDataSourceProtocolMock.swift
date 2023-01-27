//
//  MovieVisitLocalDataSourceProtocolMock.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 18/06/22.
//

@testable import UpcomingMoviesDomain

final class MovieVisitLocalDataSourceProtocolMock: MovieVisitLocalDataSourceProtocol {

    var didUpdateMovieVisit: (() -> Void)?

    var getMovieVisitsResult: Result<[MovieVisit], Error>?
    private(set) var getMovieVisitsCallCount = 0
    func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void) {
        if let getMovieVisitsResult = getMovieVisitsResult {
            completion(getMovieVisitsResult)
        }
        getMovieVisitsCallCount += 1
    }

    var saveResult: Result<Void, Error>?
    private(set) var saveCallCount = 0
    func save(with id: Int, title: String, posterPath: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        if let saveResult = saveResult {
            completion(saveResult)
        }
        saveCallCount += 1
    }

}

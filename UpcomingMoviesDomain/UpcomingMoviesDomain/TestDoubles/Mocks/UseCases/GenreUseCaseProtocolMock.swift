//
//  GenreUseCaseProtocolMock.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/06/23.
//

import Foundation

public final class GenreUseCaseProtocolMock: GenreUseCaseProtocol {

    public var didUpdateGenre: (() -> Void)?

    var findResult: Result<UpcomingMoviesDomain.Genre?, Error>?
    private(set) var findCallCount = 0
    public func find(with id: Int, completion: @escaping (Result<UpcomingMoviesDomain.Genre?, Error>) -> Void) {
        if let findResult {
            completion(findResult)
        }
        findCallCount += 1
    }

    var fetchAllResult: Result<[UpcomingMoviesDomain.Genre], Error>?
    private(set) var fetchAllCallCount = 0
    public func fetchAll(completion: @escaping (Result<[UpcomingMoviesDomain.Genre], Error>) -> Void, forceRefresh: Bool) {
        if let fetchAllResult {
            completion(fetchAllResult)
        }
        fetchAllCallCount += 1
    }

}

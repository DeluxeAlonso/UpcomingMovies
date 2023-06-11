//
//  MockInjectionFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/18/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import UpcomingMoviesData
@testable import CoreDataInfrastructure
@testable import NetworkInfrastructure

final class MockInjectionFactory {

    class func useCaseProvider() -> UseCaseProviderProtocol {
        let localDataSource = makeLocalDataSource()
        let remoteDataSource = makeRemoteDataSource()
        return MockUseCaseProvider(localDataSource: localDataSource,
                                   remoteDataSource: remoteDataSource)
    }

    class func makeLocalDataSource() -> LocalDataSourceProtocol {
        LocalDataSource()
    }

    class func makeRemoteDataSource() -> RemoteDataSourceProtocol {
        RemoteDataSource()
    }

}

final class MockUseCaseProvider: UseCaseProvider {

    var mockMovieUseCase: MovieUseCaseProtocolMock!
    var mockGenreUseCase: GenreUseCaseProtocolMock!

    override func movieUseCase() -> MovieUseCaseProtocol {
        mockMovieUseCase!
    }

    override func genreUseCase() -> GenreUseCaseProtocol {
        mockGenreUseCase!
    }

}

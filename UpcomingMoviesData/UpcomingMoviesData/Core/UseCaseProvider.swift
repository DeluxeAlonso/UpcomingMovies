//
//  UseCaseProvider.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public class UseCaseProvider: UseCaseProviderProtocol {

    private let localDataSource: LocalDataSourceProtocol
    private let remoteDataSource: RemoteDataSourceProtocol

    public init(localDataSource: LocalDataSourceProtocol,
                remoteDataSource: RemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    public func movieUseCase() -> MovieUseCaseProtocol {
        let remoteDataSource = remoteDataSource.movieDataSource()
        return MovieRepository(remoteDataSource: remoteDataSource)
    }

    public func genreUseCase() -> GenreUseCaseProtocol {
        let localDataSource = localDataSource.genreDataSource()
        let remoteDataSource = remoteDataSource.genreDataSource()
        return GenreRepository(localDataSource: localDataSource,
                               remoteDataSource: remoteDataSource)
    }

    public func movieVisitUseCase() -> MovieVisitUseCaseProtocol {
        let localDataSource = localDataSource.movieVisitDataSource()
        return MovieVisitRepository(localDataSource: localDataSource)
    }

    public func movieSearchUseCase() -> MovieSearchUseCaseProtocol {
        let localDataSource = localDataSource.movieSearchDataSource()
        return MovieSearchRepository(localDataSource: localDataSource)
    }

    public func userUseCase() -> UserUseCaseProtocol {
        let localDataSource = localDataSource.userDataSource()
        return UserRepository(localDataSource: localDataSource)
    }

    public func accountUseCase() -> AccountUseCaseProtocol {
        let remoteDataSource = remoteDataSource.accountDataSource()
        return AccountRepository(remoteDataSource: remoteDataSource)
    }

    public func authUseCase() -> AuthUseCaseProtocol {
        let remoteDataSource = remoteDataSource.authDataSource()
        return AuthRepository(remoteDataSource: remoteDataSource)
    }

    public func configurationUseCase() -> ConfigurationUseCaseProtocol {
        let remoteDataSource = remoteDataSource.configurationDataSource()
        return ConfigurationRepository(remoteDataSource: remoteDataSource)
    }

}

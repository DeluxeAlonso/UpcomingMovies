//
//  MockInjectionFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/18/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import UpcomingMoviesData
import CoreDataInfrastructure
import NetworkInfrastructure

final class MockInjectionFactory {
    
    class func useCaseProvider() -> UseCaseProviderProtocol {
        let localDataSource = makeLocalDataSource()
        let remoteDataSource = makeRemoteDataSource()
        return UseCaseProvider(localDataSource: localDataSource,
                               remoteDataSource: remoteDataSource)
    }
    
    class func makeLocalDataSource() -> LocalDataSourceProtocol {
        return LocalDataSource()
    }
    
    class func makeRemoteDataSource() -> RemoteDataSourceProtocol {
        return RemoteDataSource()
    }
    
}

private final class MockMovieUseCase: MovieUseCaseProtocol {
    
    private var remoteDataSource: MovieRemoteDataSourceProtocol
    
    init(remoteDataSource: MovieRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    var getMovieReviews: Result<[Review], Error>?
    
    func getMovies(page: Int, movieListFilter: MovieListFilter, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
    }
    
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        
    }
    
    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
    }
    
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[Video], Error>) -> Void) {
        
    }
    
    func getMovieCredits(for movieId: Int, page: Int?, completion: @escaping (Result<MovieCredits, Error>) -> Void) {
        
    }
    
    func isMovieInFavorites(for movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        
    }
    
    func isMovieInWatchList(for movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        
    }
    
    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[Review], Error>) -> Void) {
        completion(getMovieReviews!)
    }
    
}

public class MockUseCaseProvider: UseCaseProviderProtocol {
    
    private let localDataSource: LocalDataSourceProtocol
    private let remoteDataSource: RemoteDataSourceProtocol
    
    public init(localDataSource: LocalDataSourceProtocol,
                remoteDataSource: RemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    public func movieUseCase() -> MovieUseCaseProtocol {
        let remoteDataSource = self.remoteDataSource.movieDataSource()
        return MockMovieUseCase(remoteDataSource: remoteDataSource)
    }
    
    public func genreUseCase() -> GenreUseCaseProtocol {
        let localDataSource = self.localDataSource.genreDataSource()
        let remoteDataSource = self.remoteDataSource.genreDataSource()
        return GenreRepository(localDataSource: localDataSource,
                               remoteDataSource: remoteDataSource)
    }
    
    public func movieVisitUseCase() -> MovieVisitUseCaseProtocol {
        let localDataSource = self.localDataSource.movieVisitDataSource()
        return MovieVisitRepository(localDataSource: localDataSource)
    }
    
    public func movieSearchUseCase() -> MovieSearchUseCaseProtocol {
        let localDataSource = self.localDataSource.movieSearchDataSource()
        return MovieSearchRepository(localDataSource: localDataSource)
    }
    
    public func userUseCase() -> UserUseCaseProtocol {
        let localDataSource = self.localDataSource.userDataSource()
        return UserRepository(localDataSource: localDataSource)
    }
    
    public func accountUseCase() -> AccountUseCaseProtocol {
        let remoteDataSource = self.remoteDataSource.accountDataSource()
        return AccountRepository(remoteDataSource: remoteDataSource)
    }
    
    public func authUseCase() -> AuthUseCaseProtocol {
        let remoteDataSource = self.remoteDataSource.authDataSource()
        return AuthRepository(remoteDataSource: remoteDataSource)
    }
    
}

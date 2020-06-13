//
//  MockInjectionFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/18/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
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
        return LocalDataSource()
    }
    
    class func makeRemoteDataSource() -> RemoteDataSourceProtocol {
        return RemoteDataSource()
    }
    
}

class MockUseCaseProvider: UseCaseProvider {
    
    var mockMovieUseCase: MockMovieUseCase!
    var mockGenreUseCase: MockGenreUseCase!
    
    override func movieUseCase() -> MovieUseCaseProtocol {
        return mockMovieUseCase!
    }
    
    override func genreUseCase() -> GenreUseCaseProtocol {
        return mockGenreUseCase!
    }
    
}

final class MockMovieUseCase: MovieUseCaseProtocol {
    
    private var remoteDataSource: MovieRemoteDataSourceProtocol
    
    init(remoteDataSource: MovieRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
//    var movies: Result<[UpcomingMoviesDomain.Movie], Error>?
//    func getMovies(page: Int, movieListFilter: MovieListFilter, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
//        completion(movies!)
//    }
    
    var upcomingMovies: Result<[UpcomingMoviesDomain.Movie], Error>?
    func getUpcomingMovies(page: Int,
                           completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        completion(upcomingMovies!)
    }
    
    var popularMovies: Result<[UpcomingMoviesDomain.Movie], Error>?
    func getPopularMovies(page: Int,
                          completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        completion(popularMovies!)
    }
    
    var topRatedMovies: Result<[UpcomingMoviesDomain.Movie], Error>?
    func getTopRatedMovies(page: Int,
                           completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        completion(topRatedMovies!)
    }
    
    var moviesbyGenre: Result<[UpcomingMoviesDomain.Movie], Error>?
    func getMoviesByGenre(page: Int, genreId: Int,
                          completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        completion(moviesbyGenre!)
    }
    
    var similarmovies: Result<[UpcomingMoviesDomain.Movie], Error>?
    func getSimilarMovies(page: Int, movieId: Int,
                          completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        completion(similarmovies!)
    }
    
    var movieDetail: Result<UpcomingMoviesDomain.Movie, Error>?
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<UpcomingMoviesDomain.Movie, Error>) -> Void) {
        completion(movieDetail!)
    }
    
    var searchedMovies: Result<[UpcomingMoviesDomain.Movie], Error>?
    func searchMovies(searchText: String, includeAdult: Bool,
                      page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        completion(searchedMovies!)
    }
    
    var videos: Result<[UpcomingMoviesDomain.Video], Error>?
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Video], Error>) -> Void) {
        completion(videos!)
    }
    
    var credits: Result<MovieCredits, Error>?
    func getMovieCredits(for movieId: Int, page: Int?, completion: @escaping (Result<MovieCredits, Error>) -> Void) {
        completion(credits!)
    }
    
    var isFavorite: Result<Bool, Error>?
    func isMovieInFavorites(for movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(isFavorite!)
    }
    
    var isInWatchlist: Result<Bool, Error>?
    func isMovieInWatchList(for movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(isInWatchlist!)
    }
    
    var reviews: Result<[UpcomingMoviesDomain.Review], Error>?
    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Review], Error>) -> Void) {
        completion(reviews!)
    }
    
}

final class MockGenreUseCase: GenreUseCaseProtocol {
    
    private var localDataSource: GenreLocalDataSourceProtocol
    private var remoteDataSource: GenreRemoteDataSourceProtocol
    
    init(localDataSource: GenreLocalDataSourceProtocol,
         remoteDataSource: GenreRemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    var didUpdateGenre: (() -> Void)?
    
    func find(with id: Int, completion: @escaping (Result<UpcomingMoviesDomain.Genre?, Error>) -> Void) {
        completion(.success(Genre.with(id: 1, name: "Genre 1")))
    }
    
    var genres: Result<[UpcomingMoviesDomain.Genre], Error>?
    func fetchAll(completion: @escaping (Result<[UpcomingMoviesDomain.Genre], Error>) -> Void) {
        completion(genres!)
    }
    
}

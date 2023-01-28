//
//  AccountRemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain
import UpcomingMoviesData

final class AccountRemoteDataSource: AccountRemoteDataSourceProtocol {

    private let client: AccountClientProtocol
    private let authManager: AuthenticationManagerProtocol

    init(client: AccountClientProtocol,
         authManager: AuthenticationManagerProtocol = AuthenticationManager.shared) {
        self.client = client
        self.authManager = authManager
    }

    func getFavoriteList(page: Int?, sortBy: MovieSortType.Favorite, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.getFavoriteList(page: page ?? 1, sortBy: sortBy, sessionId: account.sessionId, accountId: account.accountId, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getWatchlist(page: Int?, sortBy: MovieSortType.Watchlist, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.getWatchlist(page: page ?? 1, sortBy: sortBy, sessionId: account.sessionId, accountId: account.accountId, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getRecommendedList(page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        guard let accountId = authManager.accessToken?.accountId,
              let accessToken = authManager.accessToken?.token else {
            return
        }
        client.getRecommendedList(page: page ?? 1, accessToken: accessToken, accountId: accountId) { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCustomLists(page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.List], Error>) -> Void) {
        guard let accountId = authManager.accessToken?.accountId,
              let accessToken = authManager.accessToken?.token else {
            return
        }
        client.getCustomLists(page: page ?? 1, accessToken: accessToken, accountId: accountId, completion: { result in
            switch result {
            case .success(let listResult):
                guard let listResult = listResult else { return }
                let lists = listResult.results.map { $0.asDomain() }
                completion(.success(lists))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getCustomListMovies(listId: String, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        guard let accessToken = authManager.accessToken?.token else { return }
        client.getCustomListMovies(with: accessToken, listId: listId, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getAccountDetail(completion: @escaping (Result<UpcomingMoviesDomain.User, Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.getAccountDetail(with: account.sessionId, completion: { result in
            switch result {
            case .success(let user):
                completion(.success(user.asDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.markAsFavorite(movieId, sessionId: account.sessionId, accountId: account.accountId, favorite: favorite, completion: { result in
            switch result {
            case .success:
                completion(.success(favorite))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func addToWatchlist(movieId: Int, watchlist: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.addToWatchlist(movieId, sessionId: account.sessionId, accountId: account.accountId, watchlist: watchlist, completion: { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

//
//  MovieSearchLocalDataSource.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain
import UpcomingMoviesData

final class MovieSearchLocalDataSource: MovieSearchLocalDataSourceProtocol {

    private let store: PersistenceStore<CDMovieSearch>

    var didUpdateMovieSearch: (() -> Void)?

    // MARK: - Initializers

    init(store: PersistenceStore<CDMovieSearch>) {
        self.store = store
        self.store.configureResultsContoller(limit: 5,
                                             sortDescriptors: CDMovieSearch.defaultSortDescriptors)
        self.store.delegate = self
    }

    // MARK: - MovieSearchLocalDataSourceProtocol

    func getMovieSearches(completion: @escaping (Result<[MovieSearch], Error>) -> Void) {
        let searches = store.findAll().map { $0.asDomain() }
        completion(.success(searches))
    }

    func save(with searchText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        store.saveMovieSearch(with: searchText)
        completion(.success(Void()))
    }

}

// MARK: - PersistenceStoreDelegate

extension MovieSearchLocalDataSource: PersistenceStoreDelegate {

    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}

    func persistenceStore(didUpdateEntity update: Bool) {
        didUpdateMovieSearch?()
    }

}

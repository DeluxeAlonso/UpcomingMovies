//
//  MovieVisitLocalDataSource.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain
import UpcomingMoviesData

final class MovieVisitLocalDataSource: MovieVisitLocalDataSourceProtocol {

    private let store: PersistenceStore<CDMovieVisit>

    var didUpdateMovieVisit: (() -> Void)?

    // MARK: - Initializers

    // TODO: - Make the limit configurable
    init(store: PersistenceStore<CDMovieVisit>) {
        self.store = store
        self.store.configureResultsContoller(limit: 10, sortDescriptors: CDMovieVisit.defaultSortDescriptors)
        self.store.delegate = self
    }

    // MARK: - MovieVisitLocalDataSourceProtocol

    func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void) {
        store.findAll(limit: 10) { movieVisits in
            completion(.success(movieVisits.map { $0.asDomain() }))
        }
    }

    func save(with id: Int, title: String, posterPath: String?,
              completion: @escaping (Result<Void, Error>) -> Void) {
        store.saveMovieVisit(with: id, title: title, posterPath: posterPath)
        completion(.success(Void()))
    }

}

// MARK: - PersistenceStoreDelegate

extension MovieVisitLocalDataSource: PersistenceStoreDelegate {

    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}

    func persistenceStore(didUpdateEntity update: Bool) {
        didUpdateMovieVisit?()
    }

}

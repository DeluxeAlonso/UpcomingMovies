//
//  MovieVisitLocalDataSource.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import UpcomingMoviesData

final class MovieVisitLocalDataSource: MovieVisitLocalDataSourceProtocol {
    
    private let store: PersistenceStore<CDMovieVisit>
    
    var didUpdateMovieVisit: (() -> Void)?
    
    init(store: PersistenceStore<CDMovieVisit>) {
        self.store = store
        self.store.configureResultsContoller(sortDescriptors: CDMovieVisit.defaultSortDescriptors)
        self.store.delegate = self
    }
    
    func getMovieVisits() -> [MovieVisit] {
        return store.entities.map { $0.asDomain() }
    }
    
    func save(with id: Int, title: String, posterPath: String?) {
        store.saveMovieVisit(with: id,
                             title: title,
                             posterPath: posterPath)
    }
    
    func hasMovieVisits() -> Bool {
        return store.exists()
    }
    
}

// MARK: - PersistenceStoreDelegate

extension MovieVisitLocalDataSource: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}
    
    func persistenceStore(didUpdateEntity update: Bool) {
        didUpdateMovieVisit?()
    }
    
}

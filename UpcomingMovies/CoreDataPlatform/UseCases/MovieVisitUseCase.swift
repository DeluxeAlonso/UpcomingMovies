//
//  MovieVisitUseCase.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol MovieVisitUseCaseDelegate: class {
    
    func didUpdateMovieVisit()
    
}

final class MovieVisitUseCase: MovieVisitUseCaseProtocol {
    
    private let store: PersistenceStore<CDMovieVisit>
    
    weak var delegate: MovieVisitUseCaseDelegate?
    
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

extension MovieVisitUseCase: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}
    
    func persistenceStore(didUpdateEntity update: Bool) {
        delegate?.didUpdateMovieVisit()
    }
    
}

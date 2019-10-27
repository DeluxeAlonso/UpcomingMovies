//
//  MovieSearchUseCase.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class MovieSearchUseCase: MovieSearchUseCaseProtocol {
    
    private let store: PersistenceStore<CDMovieSearch>
    
    var didUpdateMovieSearch: (() -> Void)?
    
    init(store: PersistenceStore<CDMovieSearch>) {
        self.store = store
        self.store.configureResultsContoller(limit: 5,
                                             sortDescriptors: CDMovieSearch.defaultSortDescriptors)
        self.store.delegate = self
    }
    
    func getMovieSearchs() -> [MovieSearch] {
        return store.entities.map { $0.asDomain() }
    }
    
    func save(with searchText: String) {
        store.saveMovieSearch(with: searchText)
    }
    
}

// MARK: - PersistenceStoreDelegate

extension MovieSearchUseCase: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}
    
    func persistenceStore(didUpdateEntity update: Bool) {
        didUpdateMovieSearch?()
    }
    
}

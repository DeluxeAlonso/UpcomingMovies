//
//  GenreUseCase.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class GenreUseCase: GenreUseCaseProtocol {
    
    private let store: PersistenceStore<CDGenre>
    
    var didUpdateGenre: (() -> Void)?
    
    init(store: PersistenceStore<CDGenre>) {
        self.store = store
        self.store.configureResultsContoller(sortDescriptors: CDGenre.defaultSortDescriptors)
        self.store.delegate = self
    }
    
    func saveGenres(_ genres: [Genre]) {
        genres.forEach { store.saveGenre($0) }
    }
    
    func find(with id: Int) -> Genre? {
        return store.find(with: id)?.asDomain()
    }
    
    func findAll() -> [Genre] {
        return store.findAll().map { $0.asDomain() }
    }
    
}

// MARK: - PersistenceStoreDelegate

extension GenreUseCase: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}
    
    func persistenceStore(didUpdateEntity update: Bool) {
        didUpdateGenre?()
    }
    
}

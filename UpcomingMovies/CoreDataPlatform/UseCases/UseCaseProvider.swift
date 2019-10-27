//
//  UseCaseProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class UseCaseProvider: UseCaseProviderProtocol {
    
    private let coreDataStack: CoreDataStack
    private let genreStore: PersistenceStore<CDGenre>
    private let movieVisitStore: PersistenceStore<CDMovieVisit>
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
        self.genreStore = PersistenceStore(self.coreDataStack.mainContext)
        self.movieVisitStore = PersistenceStore(self.coreDataStack.mainContext)
    }
    
    func genreUseCase() -> GenreUseCaseProtocol {
        return GenreUseCase(store: genreStore)
    }
    
    func movieVisitUseCase() -> MovieVisitUseCaseProtocol {
        return MovieVisitUseCase(store: movieVisitStore)
    }
    
}

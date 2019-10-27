//
//  UseCaseProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class UseCaseProvider: UseCaseProviderProtocol {
    
    private let coreDataStack: PersistenceManager
    private let movieVisitStore: PersistenceStore<CDMovieVisit>
    
    init(coreDataStack: PersistenceManager = PersistenceManager.shared) {
        self.coreDataStack = coreDataStack
        self.movieVisitStore = PersistenceStore(self.coreDataStack.mainContext)
    }
    
    func movieVisitUseCase() -> MovieVisitUseCaseProtocol {
        return MovieVisitUseCase(store: movieVisitStore)
    }
    
}

//
//  UseCaseProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain

final public class UseCaseProvider: UseCaseProviderProtocol {
    
    private let coreDataStack: CoreDataStack
    
    public init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    public func genreUseCase() -> GenreUseCaseProtocol {
        let genreStore: PersistenceStore<CDGenre> = PersistenceStore(self.coreDataStack.mainContext)
        return GenreUseCase(store: genreStore)
    }
    
    public func movieVisitUseCase() -> MovieVisitUseCaseProtocol {
        let movieVisitStore: PersistenceStore<CDMovieVisit> = PersistenceStore(self.coreDataStack.mainContext)
        return MovieVisitUseCase(store: movieVisitStore)
    }
    
    public func movieSearchUseCase() -> MovieSearchUseCaseProtocol {
        let movieSearchStore: PersistenceStore<CDMovieSearch> = PersistenceStore(self.coreDataStack.mainContext)
        return MovieSearchUseCase(store: movieSearchStore)
    }
    
    public func userUseCase() -> UserUseCaseProtocol {
        let userStore: PersistenceStore<CDUser> = PersistenceStore(self.coreDataStack.mainContext)
        return UserUseCase(store: userStore)
    }
    
}

//
//  InteractorAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import Swinject

class InteractorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SavedMoviesInteractorProtocol.self,
                           name: ProfileCollectionOption.favorites.title) { resolver in
                            FavoritesSavedMoviesInteractor(useCaseProvider: resolver.resolve(UseCaseProviderProtocol.self)!)
        }
        container.register(SavedMoviesInteractorProtocol.self,
                           name: ProfileCollectionOption.watchlist.title) { resolver in
                            WatchListSavedMoviesInteractor(useCaseProvider: resolver.resolve(UseCaseProviderProtocol.self)!)
        }
    }
    
}

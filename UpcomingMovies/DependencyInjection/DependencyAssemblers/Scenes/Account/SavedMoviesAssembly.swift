//
//  SavedMoviesAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Swinject
import UpcomingMoviesDomain

final class SavedMoviesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SavedMoviesInteractorProtocol.self,
                           name: ProfileCollectionOption.favorites.title) { resolver in
                            FavoritesSavedMoviesInteractor(useCaseProvider: resolver.resolve(UseCaseProviderProtocol.self)!)
        }
        container.register(SavedMoviesInteractorProtocol.self,
                           name: ProfileCollectionOption.watchlist.title) { resolver in
                            WatchListSavedMoviesInteractor(useCaseProvider: resolver.resolve(UseCaseProviderProtocol.self)!)
        }
        container.register(SavedMoviesViewModelProtocol.self) { (resolver, displayTitle: String?) in
            let interactor = resolver.resolve(SavedMoviesInteractorProtocol.self, name: displayTitle)
            let viewStateHandler = resolver.resolve(ViewStateHandlerProtocol.self)
            
            let viewModel = SavedMoviesViewModel(interactor: interactor!, viewStateHandler: viewStateHandler!)
            viewModel.displayTitle = displayTitle
            
            return viewModel
        }
    }
    
}

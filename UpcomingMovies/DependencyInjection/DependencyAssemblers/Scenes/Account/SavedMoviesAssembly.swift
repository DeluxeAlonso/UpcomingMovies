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
                           name: ProfileOption.favorites.title) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return FavoritesSavedMoviesInteractor(useCaseProvider: useCaseProvider)
        }

        container.register(SavedMoviesInteractorProtocol.self,
                           name: ProfileOption.watchlist.title) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return WatchlistSavedMoviesInteractor(useCaseProvider: useCaseProvider)
        }

        container.register(SavedMoviesViewModelProtocol.self) { (resolver, displayTitle: String?) in
            guard let interactor = resolver.resolve(SavedMoviesInteractorProtocol.self, name: displayTitle) else {
                fatalError("SavedMoviesInteractorProtocol dependency could not be resolved")
            }
            let viewModel = SavedMoviesViewModel(interactor: interactor)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

}

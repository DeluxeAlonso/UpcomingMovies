//
//  MovieListAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

final class MovieListAssembly: Assembly {

    func assemble(container: Container) {
        popularMoviesAssemble(container: container)
        topRatedMoviesAssemble(container: container)
        similarMoviesAssemble(container: container)
        moviesByGenreAssemble(container: container)
        recommendedMoviesAssemble(container: container)
    }

    private func popularMoviesAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "PopularMovies") { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return PopularMoviesInteractor(useCaseProvider: useCaseProvider!)
        }

        container.register(MovieListViewModelProtocol.self, name: "PopularMovies") { (resolver, displayTitle: String) in
            let interactor = resolver.resolve(MoviesInteractorProtocol.self, name: "PopularMovies")

            let viewModel = MovieListViewModel(interactor: interactor!)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

    private func topRatedMoviesAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "TopRatedMovies") { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return TopRatedMoviesInteractor(useCaseProvider: useCaseProvider!)
        }

        container.register(MovieListViewModelProtocol.self, name: "TopRatedMovies") { (resolver, displayTitle: String) in
            let interactor = resolver.resolve(MoviesInteractorProtocol.self, name: "TopRatedMovies")

            let viewModel = MovieListViewModel(interactor: interactor!)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

    private func similarMoviesAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "SimilarMovies") { (resolver, movieId: Int) in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return SimilarMoviesInteractor(useCaseProvider: useCaseProvider!, movieId: movieId)
        }

        container.register(MovieListViewModelProtocol.self, name: "SimilarMovies") { (resolver, displayTitle: String, movieId: Int?) in
            let interactor = resolver.resolve(MoviesInteractorProtocol.self,
                                              name: "SimilarMovies", argument: movieId!)

            let viewModel = MovieListViewModel(interactor: interactor!)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

    private func moviesByGenreAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "MoviesByGenre") { (resolver, genreId: Int, genreName: String) in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return MoviesByGenreInteractor(useCaseProvider: useCaseProvider!,
                                           genreId: genreId, genreName: genreName)
        }

        container.register(MovieListViewModelProtocol.self, name: "MoviesByGenre") { (resolver, genreId: Int?, genreName: String?) in
            let interactor = resolver.resolve(MoviesInteractorProtocol.self,
                                              name: "MoviesByGenre",
                                              arguments: genreId!, genreName!)

            let viewModel = MovieListViewModel(interactor: interactor!)
            viewModel.displayTitle = genreName

            return viewModel
        }
    }

    private func recommendedMoviesAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "RecommendedMovies") { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return RecommendedMoviesInteractor(useCaseProvider: useCaseProvider!)
        }

        container.register(MovieListViewModelProtocol.self, name: "RecommendedMovies") { (resolver, displayTitle: String) in
            let interactor = resolver.resolve(MoviesInteractorProtocol.self,
                                              name: "RecommendedMovies")

            let viewModel = MovieListViewModel(interactor: interactor!)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

}

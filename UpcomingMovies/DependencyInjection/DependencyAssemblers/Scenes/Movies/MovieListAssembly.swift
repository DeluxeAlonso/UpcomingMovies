//
//  MovieListAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

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
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return PopularMoviesInteractor(movieUseCase: useCaseProvider.movieUseCase())
        }

        container.register(MovieListViewModelProtocol.self, name: "PopularMovies") { (resolver, displayTitle: String) in
            guard let interactor = resolver.resolve(MoviesInteractorProtocol.self, name: "PopularMovies") else {
                fatalError("MoviesInteractorProtocol dependency could not be resolved")
            }
            let viewModel = MovieListViewModel(interactor: interactor)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

    private func topRatedMoviesAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "TopRatedMovies") { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return TopRatedMoviesInteractor(movieUseCase: useCaseProvider.movieUseCase())
        }

        container.register(MovieListViewModelProtocol.self, name: "TopRatedMovies") { (resolver, displayTitle: String) in
            guard let interactor = resolver.resolve(MoviesInteractorProtocol.self, name: "TopRatedMovies") else {
                fatalError("MoviesInteractorProtocol dependency could not be resolved")
            }

            let viewModel = MovieListViewModel(interactor: interactor)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

    private func similarMoviesAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "SimilarMovies") { (resolver, movieId: Int) in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return SimilarMoviesInteractor(movieUseCase: useCaseProvider.movieUseCase(), movieId: movieId)
        }

        container.register(MovieListViewModelProtocol.self, name: "SimilarMovies") { (resolver, displayTitle: String, movieId: Int) in
            guard let interactor = resolver.resolve(MoviesInteractorProtocol.self,
                                                    name: "SimilarMovies", argument: movieId) else {
                fatalError("MoviesInteractorProtocol dependency could not be resolved")
            }

            let viewModel = MovieListViewModel(interactor: interactor)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

    private func moviesByGenreAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "MoviesByGenre") { (resolver, genreId: Int, genreName: String) in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return MoviesByGenreInteractor(movieUseCase: useCaseProvider.movieUseCase(),
                                           genreId: genreId, genreName: genreName)
        }

        container.register(MovieListViewModelProtocol.self, name: "MoviesByGenre") { (resolver, genreId: Int, genreName: String) in
            guard let interactor = resolver.resolve(MoviesInteractorProtocol.self, name: "MoviesByGenre", arguments: genreId, genreName) else {
                fatalError("MoviesInteractorProtocol dependency could not be resolved")
            }
            let viewModel = MovieListViewModel(interactor: interactor)
            viewModel.displayTitle = genreName

            return viewModel
        }
    }

    private func recommendedMoviesAssemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "RecommendedMovies") { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return RecommendedMoviesInteractor(accountUseCase: useCaseProvider.accountUseCase())
        }

        container.register(MovieListViewModelProtocol.self, name: "RecommendedMovies") { (resolver, displayTitle: String) in
            guard let interactor = resolver.resolve(MoviesInteractorProtocol.self,
                                                    name: "RecommendedMovies") else {
                fatalError("MoviesInteractorProtocol dependency could not be resolved")
            }
            let viewModel = MovieListViewModel(interactor: interactor)
            viewModel.displayTitle = displayTitle

            return viewModel
        }
    }

}

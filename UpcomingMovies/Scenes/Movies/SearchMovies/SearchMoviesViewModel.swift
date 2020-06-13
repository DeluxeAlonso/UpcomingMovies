//
//  SearchMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SearchMoviesViewModel: NSObject {
    
    private var useCaseProvider: UseCaseProviderProtocol
    private var genreUseCase: GenreUseCaseProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.useCaseProvider = useCaseProvider
        self.genreUseCase = useCaseProvider.genreUseCase()
    }
    
    func buildSearchOptionsViewModel() -> SearchOptionsViewModel {
        return SearchOptionsViewModel(useCaseProvider: useCaseProvider)
    }
    
    func searchResultViewModel() -> SearchMoviesResultViewModel {
        return SearchMoviesResultViewModel(useCaseProvider: useCaseProvider)
    }
    
    // MARK: - Default search options
    
    func popularMoviesViewModel() -> MovieListViewModel {
        let fetchHandler = PopularMoviesFetchHandler(movieUseCase: useCaseProvider.movieUseCase())
        return MovieListViewModel(useCaseProvider: useCaseProvider,
                                  movieFetchHandler: fetchHandler)
    }
    
    func topRatedMoviesViewModel() -> MovieListViewModel {
        let fetchHandler = TopRatedMoviesFetchHandler(movieUseCase: useCaseProvider.movieUseCase())
        return MovieListViewModel(useCaseProvider: useCaseProvider,
                                  movieFetchHandler: fetchHandler)
    }
    
    func moviesByGenreViewModel(genreId: Int) -> MovieListViewModel {
        let fetchHandler = MoviesByGenreFetchHandler(movieUseCase: useCaseProvider.movieUseCase(),
                                                     genreId: genreId)
        return MovieListViewModel(useCaseProvider: useCaseProvider, movieFetchHandler: fetchHandler)
    }
    
    func recentlyVisitedMovieViewModel(id: Int, title: String) -> MovieDetailViewModel {
        return MovieDetailViewModel(id: id,
                                    title: title,
                                    useCaseProvider: useCaseProvider)
    }
    
}

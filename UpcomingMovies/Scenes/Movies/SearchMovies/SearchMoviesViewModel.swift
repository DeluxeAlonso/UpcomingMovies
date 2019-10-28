//
//  SearchMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class SearchMoviesViewModel: NSObject {
    
    private var useCaseProvider: UseCaseProviderProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol = UseCaseProvider()) {
        self.useCaseProvider = useCaseProvider
    }
    
    func buildSearchOptionsViewModel() -> SearchOptionsViewModel {
        return SearchOptionsViewModel()
    }
    
    func prepareSearchResultController() -> SearchMoviesResultController {
        let viewModel = SearchMoviesResultViewModel(useCaseProvider: useCaseProvider)
        return SearchMoviesResultController(viewModel: viewModel)
    }
    
    // MARK: - Default search options
    
    func popularMoviesViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .popular,
                                  useCaseProvider: useCaseProvider)
    }
    
    func topRatedMoviesViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .topRated,
                                  useCaseProvider: useCaseProvider)
    }
    
    func moviesByGenreViewModel(genreId: Int) -> MovieListViewModel {
        return MovieListViewModel(filter: .byGenre(genreId: genreId),
                                  useCaseProvider: useCaseProvider)
    }
    
    func recentlyVisitedMovieViewModel(id: Int, title: String) -> MovieDetailViewModel {
        return MovieDetailViewModel(id: id,
                                    title: title)
    }
    
}

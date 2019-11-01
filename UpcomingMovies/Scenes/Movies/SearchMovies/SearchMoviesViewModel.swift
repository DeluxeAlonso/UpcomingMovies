//
//  SearchMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import Domain

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
        let genreName = genreUseCase.find(with: genreId)?.name ?? "-"
        return MovieListViewModel(filter: .byGenre(genreId: genreId, genreName: genreName),
                                  useCaseProvider: useCaseProvider)
    }
    
    func recentlyVisitedMovieViewModel(id: Int, title: String) -> MovieDetailViewModel {
        return MovieDetailViewModel(id: id,
                                    title: title,
                                    useCaseProvider: useCaseProvider)
    }
    
}

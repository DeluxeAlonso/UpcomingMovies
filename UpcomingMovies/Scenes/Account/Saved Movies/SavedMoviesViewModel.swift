//
//  SavedMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SavedMoviesViewModel: SavedMoviesViewModelProtocol {
    
    private let interactor: SavedMoviesInteractorProtocol
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    private var movies: [Movie] {
        return viewState.value.currentEntities
    }
    
    var movieCells: [SavedMovieCellViewModel] {
        return movies.compactMap { SavedMovieCellViewModel($0) }
    }
    
    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }
    
    var title: String?
    
    // MARK: - Initializers
    
    init(interactor: SavedMoviesInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: - Public
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    // MARK: - Networking
    
    func getCollectionList() {
        let showLoader = viewState.value.isInitialPage
        fetchCollectionList(page: viewState.value.currentPage, showLoader: showLoader)
    }
    
    func refreshCollectionList() {
        fetchCollectionList(page: 1, showLoader: false)
    }
    
    private func fetchCollectionList(page: Int, showLoader: Bool) {
        startLoading.value = showLoader
        interactor.getSavedMovies(page: page) { result in
            self.startLoading.value = false
            switch result {
            case .success(let movies):
                self.viewState.value = self.processResult(movies,
                                                          currentPage: page,
                                                          currentMovies: self.movies)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    private func processResult(_ movies: [Movie], currentPage: Int,
                               currentMovies: [Movie]) -> SimpleViewState<Movie> {
        var allMovies = currentPage == 1 ? [] : currentMovies
        allMovies.append(contentsOf: movies)
        guard !allMovies.isEmpty else { return .empty }
        
        return movies.isEmpty ? .populated(allMovies) : .paging(allMovies, next: currentPage + 1)
    }
    
}

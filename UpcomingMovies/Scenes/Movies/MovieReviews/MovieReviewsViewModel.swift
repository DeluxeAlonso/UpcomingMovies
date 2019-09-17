//
//  MovieReviewsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class MovieReviewsViewModel {
    
    private let interactor: MovieReviewsInteractorProtocol
    
    let movieId: Int
    let movieTitle: String
    
    let viewState: Bindable<SimpleViewState<Review>> = Bindable(.initial)
    
    var startLoading: Bindable<Bool> = Bindable(false)
    
    var reviewCells: [MovieReviewCellViewModel] {
        let reviews = viewState.value.currentEntities
        return reviews.map { MovieReviewCellViewModel($0) }
    }
    
    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String, interactor: MovieReviewsInteractorProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        self.interactor = interactor
    }
    
    func shouldPrefetch() -> Bool {
        switch viewState.value {
        case .paging:
            return true
        case .empty, .populated, .error, .initial:
            return false
        }
    }
    
    // MARK: - Networking
    
    func getMovieReviews() {
        let showLoader = viewState.value.isInitialPage
        fetchMovieReviews(currentPage: viewState.value.currentPage, showLoader: showLoader)
    }
    
    func refreshMovieReviews() {
        fetchMovieReviews(currentPage: 1, showLoader: false)
    }
    
    private func fetchMovieReviews(currentPage: Int, showLoader: Bool = false) {
        startLoading.value = showLoader
        interactor.fetchMovieReviews(page: currentPage, movieId: movieId,
                                                 currentReviews: viewState.value.currentEntities,
                                                 completion: { state in
            self.startLoading.value = false
            self.viewState.value = state
        })
    }
    
}

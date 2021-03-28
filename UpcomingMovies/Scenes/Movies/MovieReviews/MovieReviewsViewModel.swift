//
//  MovieReviewsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieReviewsViewModel: MovieReviewsViewModelProtocol {

    // MARK: - Dependencies

    private let movieId: Int
    private let interactor: MovieReviewsInteractorProtocol
    private let viewStateHandler: ViewStateHandlerProtocol

    // MARK: - Reactive properties
    
    let viewState: Bindable<SimpleViewState<Review>> = Bindable(.initial)
    let startLoading: Bindable<Bool> = Bindable(false)

    // MARK: - Computed properties
    
    private var reviews: [Review] {
        return viewState.value.currentEntities
    }
    
    var reviewCells: [MovieReviewCellViewModelProtocol] {
        let reviews = viewState.value.currentEntities
        return reviews.map { MovieReviewCellViewModel($0) }
    }
    
    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }

    // MARK: - Stored properties

    var movieTitle: String
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String,
         interactor: MovieReviewsInteractorProtocol,
         viewStateHandler: ViewStateHandlerProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        
        self.interactor = interactor
        self.viewStateHandler = viewStateHandler
    }
    
    // MARK: - MovieReviewsViewModelProtocol
    
    func selectedReview(at index: Int) -> Review {
        return reviews[index]
    }

    func getMovieReviews() {
        let showLoader = viewState.value.isInitialPage
        fetchMovieReviews(currentPage: viewState.value.currentPage, showLoader: showLoader)
    }
    
    func refreshMovieReviews() {
        fetchMovieReviews(currentPage: 1, showLoader: false)
    }

    // MARK: - Private
    
    private func fetchMovieReviews(currentPage: Int, showLoader: Bool = false) {
        startLoading.value = showLoader
        interactor.getMovieReviews(for: movieId, page: currentPage, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let reviews):
                self.viewState.value = self.viewStateHandler.processResult(reviews,
                                                                           currentPage: currentPage,
                                                                           currentEntities: self.reviews)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
}

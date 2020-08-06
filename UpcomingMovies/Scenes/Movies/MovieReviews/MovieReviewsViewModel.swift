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
    
    private var movieId: Int
    var movieTitle: String
    
    private let interactor: MovieReviewsInteractorProtocol
    
    let viewState: Bindable<SimpleViewState<Review>> = Bindable(.initial)
    
    var startLoading: Bindable<Bool> = Bindable(false)
    
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
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String, interactor: MovieReviewsInteractorProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        
        self.interactor = interactor
    }
    
    // MARK: - Public
    
    func selectedReview(at index: Int) -> Review {
        return reviews[index]
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
        interactor.getMovieReviews(for: movieId, page: currentPage, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let reviews):
                self.viewState.value = self.processResult(reviews,
                                                          currentPage: currentPage,
                                                          currentReviews: self.reviews)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processResult(_ reviews: [Review], currentPage: Int,
                               currentReviews: [Review]) -> SimpleViewState<Review> {
        var allReviews = currentPage == 1 ? [] : currentReviews
        allReviews.append(contentsOf: reviews)
        guard !allReviews.isEmpty else { return .empty }
        
        return reviews.isEmpty ? .populated(allReviews) : .paging(allReviews, next: currentPage + 1)
    }
    
}

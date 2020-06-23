//
//  MovieReviewsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieReviewsViewModel {
    
    let movieId: Int
    let movieTitle: String
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let movieUseCase: MovieUseCaseProtocol
    
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
    
    init(movieId: Int, movieTitle: String, useCaseProvider: UseCaseProviderProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        
        self.useCaseProvider = useCaseProvider
        self.movieUseCase = self.useCaseProvider.movieUseCase()
    }
    
    // MARK: - Public
    
    func buildReviewDetailViewModel(at index: Int) -> MovieReviewDetailViewModel {
        let review = viewState.value.currentEntities[index]
        return MovieReviewDetailViewModel(review: review)
    }
    
    func selectedReview(at index: Int) -> Review {
        return viewState.value.currentEntities[index]
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
        movieUseCase.getMovieReviews(for: movieId, page: currentPage, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let reviews):
                self.processReviewResult(reviews, currentPage: currentPage)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processReviewResult(_ reviews: [Review], currentPage: Int) {
        var allReviews = currentPage == 1 ? [] : viewState.value.currentEntities
        allReviews.append(contentsOf: reviews)
        guard !allReviews.isEmpty else {
            viewState.value = .empty
            return
        }
        if reviews.isEmpty {
            viewState.value = .populated(allReviews)
        } else {
            viewState.value = .paging(allReviews, next: currentPage + 1)
        }
    }
    
}

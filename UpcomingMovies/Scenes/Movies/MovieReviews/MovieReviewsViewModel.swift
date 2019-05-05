//
//  MovieReviewsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class MovieReviewsViewModel {
    
    let movieId: Int
    let movieTitle: String
    
    var movieClient = MovieClient()
    let viewState: Bindable<SimpleViewState<Review>> = Bindable(.initial)
    
    var startLoading: Bindable<Bool> = Bindable(false)
    
    var reviewCells: [MovieReviewCellViewModel] {
        return reviews.map { MovieReviewCellViewModel($0) }
    }
    
    private var reviews: [Review] {
        return viewState.value.currentEntities
    }
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String) {
        self.movieId = movieId
        self.movieTitle = movieTitle
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
        startLoading.value = true
        movieClient.getMovieReviews(page: viewState.value.currentPage, with: movieId) { result in
            switch result {
            case .success(let reviewResult):
                guard let reviewResult = reviewResult else { return }
                self.processReviewResult(reviewResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    private func processReviewResult(_ reviewResult: ReviewResult) {
        startLoading.value = false
        let fetchedReviews = reviewResult.results
        var allReviews = reviewResult.currentPage == 1 ? [] : viewState.value.currentEntities
        allReviews.append(contentsOf: fetchedReviews)
        guard !allReviews.isEmpty else {
            viewState.value = .empty
            return
        }
        if reviewResult.hasMorePages {
            viewState.value = .paging(allReviews, next: reviewResult.nextPage)
        } else {
            viewState.value = .populated(allReviews)
        }
    }
    
}

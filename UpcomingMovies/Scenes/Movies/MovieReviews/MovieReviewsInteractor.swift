//
//  MovieReviewsInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/16/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol MovieReviewsInteractorProtocol {
    func fetchMovieReviews(page: Int, movieId: Int, currentReviews: [Review], completion: @escaping (SimpleViewState<Review>) -> Void)
}

class MovieReviewsInteractor: MovieReviewsInteractorProtocol {
    
    private let movieClient: MovieClient
    
    init(movieClient: MovieClient = MovieClient()) {
        self.movieClient = movieClient
    }
    
    func fetchMovieReviews(page: Int, movieId: Int, currentReviews: [Review], completion: @escaping (SimpleViewState<Review>) -> Void) {
        movieClient.getMovieReviews(page: page, with: movieId) { result in
            switch result {
            case .success(let reviewResult):
                guard let reviewResult = reviewResult else { return }
                //self.processReviewResult(reviewResult)
                let fetchedReviews = reviewResult.results
                var allReviews = reviewResult.currentPage == 1 ? [] : currentReviews
                allReviews.append(contentsOf: fetchedReviews)
                guard !allReviews.isEmpty else {
                    completion(.empty)
                    return
                }
                if reviewResult.hasMorePages {
                    completion(.paging(allReviews, next: reviewResult.nextPage))
                } else {
                    completion(.populated(allReviews))
                }
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
}

//
//  MovieReviewsProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol MovieReviewsViewModelProtocol {

    var movieTitle: String { get }
    var emptyReviewResultsTitle: String { get }

    var viewState: AnyBehaviorBindable<MovieReviewsViewState> { get }
    var startLoading: AnyBehaviorBindable<Bool> { get }

    var reviewCells: [MovieReviewCellViewModelProtocol] { get }
    var needsPrefetch: Bool { get }

    func selectedReview(at index: Int) -> ReviewProtocol

    func getMovieReviews()
    func refreshMovieReviews()

}

protocol MovieReviewsInteractorProtocol {

    func getMovieReviews(for movieId: Int, page: Int?,
                         completion: @escaping (Result<[ReviewProtocol], Error>) -> Void)

}

protocol MovieReviewsCoordinatorProtocol: AnyObject {

    func showReviewDetail(for review: ReviewProtocol, transitionView: UIView?)

}

//
//  MovieReviewsProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol MovieReviewsViewModelProtocol {
    
    var movieTitle: String { get set }
    
    var viewState: Bindable<SimpleViewState<Review>> { get }
    var startLoading: Bindable<Bool> { get }
    
    var reviewCells: [MovieReviewCellViewModel] { get }
    var needsPrefetch: Bool { get }
    
    func selectedReview(at index: Int) -> Review
    
    func getMovieReviews()
    func refreshMovieReviews()
    
}

protocol MovieReviewsInteractorProtocol {
    
    func getMovieReviews(for movieId: Int, page: Int?,
                         completion: @escaping (Result<[Review], Error>) -> Void)
    
}

protocol MovieReviewsCoordinatorProtocol: class {
    
    func showReviewDetail(for review: Review, transitionView: UIView?)
    
}

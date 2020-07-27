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
    
    var movieId: Int { get set }
    var movieTitle: String { get set }
    
    var viewState: Bindable<SimpleViewState<Review>> { get }
    var startLoading: Bindable<Bool> { get }
    
    var reviewCells: [MovieReviewCellViewModel] { get }
    var needsPrefetch: Bool { get }
    
    func selectedReview(at index: Int) -> Review
    
    func getMovieReviews()
    func refreshMovieReviews()
    
}

protocol MovieReviewsCoordinatorProtocol: class {
    
    func showReviewDetail(for review: Review, transitionView: UIView?)
    
}

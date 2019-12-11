//
//  ReviewsMovieDetailOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class ReviewsMovieDetailOption: MovieDetailOption {
    
    var title: String {
        return NSLocalizedString("reviewsDetailOptions", comment: "")
    }
    
    var icon: UIImage {
        return #imageLiteral(resourceName: "Reviews")
    }
    
    var identifier: String {
        return "MovieReviewsSegue"
    }
    
    func prepare(viewController: inout UIViewController, with viewModel: MovieDetailViewModel) {
        guard let viewController = viewController as? MovieReviewsViewController else { fatalError() }
        _ = viewController.view
        viewController.viewModel = viewModel.buildReviewsViewModel()
    }
    
}

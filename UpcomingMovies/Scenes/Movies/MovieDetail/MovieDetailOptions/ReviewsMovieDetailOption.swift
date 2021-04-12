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
        return LocalizedStrings.reviewsDetailOptions()
    }
    
    var icon: UIImage {
        return #imageLiteral(resourceName: "Reviews")
    }
    
    func prepare(coordinator: MovieDetailCoordinatorProtocol?) {
        coordinator?.showMovieReviews()
    }
    
}

//
//  SimilarsMovieDetailOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SimilarsMovieDetailOption: MovieDetailOption {
    
    var title: String {
        return NSLocalizedString("similarsDetailOptions", comment: "")
    }
    
    var icon: UIImage {
        return #imageLiteral(resourceName: "SimilarMovies")
    }
    
    func prepare(coordinator: MovieDetailCoordinatorProtocol?) {
        coordinator?.showSimilarMovies()
    }

}

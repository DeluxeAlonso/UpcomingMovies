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
    
    var identifier: String {
        return "MovieSimilarsSegue"
    }
    
    func prepare(viewController: inout UIViewController, with viewModel: MovieDetailViewModel) {
        guard let viewController = viewController as? MovieListViewController else { fatalError() }
        _ = viewController.view
        viewController.viewModel = viewModel.buildSimilarsViewModel()
    }

}

//
//  CreditsMovieDetailOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CreditsMovieDetailOption: MovieDetailOption {
    
    var title: String {
        return NSLocalizedString("creditsDetailOptions", comment: "")
    }
    
    var icon: UIImage {
        return #imageLiteral(resourceName: "Cast")
    }
    
    var identifier: String {
        return "MovieCreditsSegue"
    }
    
    func prepare(viewController: inout UIViewController, with viewModel: MovieDetailViewModel) {
        guard let viewController = viewController as? MovieCreditsViewController else { fatalError() }
        _ = viewController.view
        viewController.viewModel = viewModel.buildCreditsViewModel()
    }
    
}

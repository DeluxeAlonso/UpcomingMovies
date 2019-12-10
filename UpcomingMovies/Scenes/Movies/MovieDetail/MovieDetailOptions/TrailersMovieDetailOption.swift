//
//  TrailersMovieDetailOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class TrailersMovieDetailOption: MovieDetailOption {
    
    typealias ViewModel = MovieVideosViewModel
    
    var title: String {
        return NSLocalizedString("trailersDetailOptions", comment: "")
    }
    
    var icon: UIImage {
        return #imageLiteral(resourceName: "PlayVideo")
    }
    
    var identifier: String {
        return "MovieVideosSegue"
    }
    
    func prepare(viewController: inout UIViewController, with viewModel: MovieDetailViewModel) {
        guard let viewController = viewController as? MovieVideosViewController else { fatalError() }
        _ = viewController.view
        viewController.viewModel = viewModel.buildVideosViewModel()
    }
    
}

//
//  CreditsMovieDetailOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

struct CreditsMovieDetailOption: MovieDetailOption {
    
    var title: String {
        return NSLocalizedString("creditsDetailOptions", comment: "")
    }
    
    var icon: UIImage {
        return #imageLiteral(resourceName: "Cast")
    }
    
    var identifier: String {
        return "MovieCreditsSegue"
    }
    
}

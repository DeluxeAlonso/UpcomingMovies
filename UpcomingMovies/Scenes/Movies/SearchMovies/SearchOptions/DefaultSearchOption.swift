//
//  DefaultSearchOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

enum DefaultSearchOption {
    case popular, topRated

    var title: String? {
        switch self {
        case .popular:
            return LocalizedStrings.popularMoviesTitle()
        case .topRated:
            return LocalizedStrings.topRatedMoviesTitle()
        }
    }

    var subtitle: String? {
        switch self {
        case .popular:
            return LocalizedStrings.popularMoviesSubtitle()
        case .topRated:
            return LocalizedStrings.topRatedMoviesSubtitle()
        }
    }

    var icon: UIImage {
        switch self {
        case .popular:
            return #imageLiteral(resourceName: "Popular")
        case .topRated:
            return #imageLiteral(resourceName: "TopRated")
        }
    }

}

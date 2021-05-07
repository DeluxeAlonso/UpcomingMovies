//
//  MovieDetailOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

enum MovieDetailOptionEnum {

    case trailers, reviews, credits, similarMovies

    var title: String {
        switch self {
        case .trailers:
            return LocalizedStrings.trailersDetailOptions()
        case .reviews:
            return LocalizedStrings.reviewsDetailOptions()
        case .credits:
            return LocalizedStrings.creditsDetailOptions()
        case .similarMovies:
            return LocalizedStrings.similarsDetailOptions()
        }
    }

}

protocol MovieDetailOption: AnyObject {
    
    var title: String { get }
    var icon: UIImage { get }
    
   func prepare(coordinator: MovieDetailCoordinatorProtocol?)
    
}

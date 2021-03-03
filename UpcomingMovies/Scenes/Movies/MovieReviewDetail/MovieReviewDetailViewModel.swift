//
//  MovieReviewDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct MovieReviewDetailViewModel: MovieReviewDetailViewModelProtocol {
    
    let author: String
    let content: String
    
    init(review: Review) {
        self.author = review.authorName
        self.content = review.content
    }
    
}

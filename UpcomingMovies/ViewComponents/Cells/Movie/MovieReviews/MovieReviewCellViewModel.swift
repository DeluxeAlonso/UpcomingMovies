//
//  MovieReviewCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain

final class MovieReviewCellViewModel {
    
    let authorName: String
    let content: String
    
    init(_ review: Review) {
        self.authorName = review.authorName
        self.content = review.content
    }
    
}

//
//  ReviewProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 23/04/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol ReviewProtocol {

    var id: String { get }
    var authorName: String { get }
    var content: String { get }

}

struct ReviewModel: ReviewProtocol {

    let id: String
    let authorName: String
    let content: String

    init(_ review: Review) {
        self.id = review.id
        self.authorName = review.authorName
        self.content = review.content
    }

}

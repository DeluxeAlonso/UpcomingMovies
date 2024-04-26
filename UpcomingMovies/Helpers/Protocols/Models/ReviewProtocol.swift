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

extension Review: ReviewProtocol {}

final class AnyReviewProtocol: ReviewProtocol, Equatable {

    private let review: Review

    var id: String { review.id }
    var authorName: String { review.authorName }
    var content: String { review.content }

    init(_ review: Review) {
        self.review = review
    }

    static func == (lhs: AnyReviewProtocol, rhs: AnyReviewProtocol) -> Bool {
        lhs.review == rhs.review
    }

}

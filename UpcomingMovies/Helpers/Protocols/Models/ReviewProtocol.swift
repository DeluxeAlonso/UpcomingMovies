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

extension ReviewProtocol {
    func eraseToAnyReview() -> AnyReviewProtocol {
        AnyReviewProtocol(self)
    }
}

extension Review: ReviewProtocol {}

final class AnyReviewProtocol: ReviewProtocol, Equatable {

    private let review: ReviewProtocol

    var id: String { review.id }
    var authorName: String { review.authorName }
    var content: String { review.content }

    init(_ review: ReviewProtocol) {
        self.review = review
    }

    static func == (lhs: AnyReviewProtocol, rhs: AnyReviewProtocol) -> Bool {
        lhs.id == rhs.id && lhs.authorName == rhs.authorName && lhs.content == rhs.content
    }

}

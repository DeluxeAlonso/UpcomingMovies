//
//  MovieReviewDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

struct MovieReviewDetailViewModel: MovieReviewDetailViewModelProtocol {

    let author: String
    let content: String

    init(review: ReviewProtocol) {
        self.author = review.authorName
        self.content = review.content
    }

}

//
//  MockReviewProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 24/04/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

@testable import UpcomingMovies

final class MockReviewProtocol: ReviewProtocol {

    var id: String = ""
    var authorName: String = ""
    var content: String = ""

}

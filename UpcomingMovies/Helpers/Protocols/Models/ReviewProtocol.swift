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

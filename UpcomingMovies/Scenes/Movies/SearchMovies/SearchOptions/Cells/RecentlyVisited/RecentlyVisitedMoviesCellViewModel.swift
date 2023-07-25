//
//  RecentlyVisitedMoviesCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/16/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol RecentlyVisitedMoviesCellViewModelProtocol {

    var visitedMovieCells: [VisitedMovieCellViewModelProtocol] { get }

}

final class RecentlyVisitedMoviesCellViewModel: RecentlyVisitedMoviesCellViewModelProtocol {

    var visitedMovieCells: [VisitedMovieCellViewModelProtocol]

    init(visitedMovieCells: [VisitedMovieCellViewModelProtocol]) {
        self.visitedMovieCells = visitedMovieCells
    }

}

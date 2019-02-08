//
//  RecentlyVisitedMoviesCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/16/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class RecentlyVisitedMoviesCellViewModel {
    
    var visitedMovieCells: [VisitedMovieCellViewModel]
    
    init(visitedMovieCells: [VisitedMovieCellViewModel]) {
        self.visitedMovieCells = visitedMovieCells
    }
    
}

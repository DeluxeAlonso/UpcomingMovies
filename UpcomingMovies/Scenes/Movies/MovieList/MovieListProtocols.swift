//
//  MovieListProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol MovieListViewModelProtocol: MoviesViewModel {
        
    var displayTitle: String? { get set }
    var movieCells: [MovieCellViewModel] { get }
    
}

protocol MovieListCoordinatorProtocol: class {
    
    func showMovieDetail(for movie: Movie)
    
}

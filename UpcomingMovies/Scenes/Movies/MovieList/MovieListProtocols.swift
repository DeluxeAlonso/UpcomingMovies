//
//  MovieListProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol MovieListViewModelProtocol {

    var viewState: BehaviorBindable<SimpleViewState<Movie>> { get }
    var startLoading: BehaviorBindable<Bool> { get }

    var needsPrefetch: Bool { get }

    var displayTitle: String? { get set }
    var movieCells: [MovieListCellViewModelProtocol] { get }

    func getMovies()
    func refreshMovies()

    func selectedMovie(at index: Int) -> Movie

}

protocol MoviesInteractorProtocol {

    func getMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void)

}

protocol MovieListCoordinatorProtocol: AnyObject {

    func showMovieDetail(for movie: Movie)

}

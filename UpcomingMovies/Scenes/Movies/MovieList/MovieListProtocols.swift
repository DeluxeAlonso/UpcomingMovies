//
//  MovieListProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol MovieListViewModelProtocol {

    var viewState: AnyBehaviorBindable<MovieListViewState> { get }
    var startLoading: AnyBehaviorBindable<Bool> { get }

    var needsPrefetch: Bool { get }

    var emptyMovieResultsTitle: String { get }

    var displayTitle: String? { get set }
    var movieCells: [MovieListCellViewModelProtocol] { get }

    func getMovies()
    func refreshMovies()

    func selectedMovie(at index: Int) -> MovieProtocol

}

protocol MoviesInteractorProtocol {

    func getMovies(page: Int, completion: @escaping (Result<[MovieProtocol], Error>) -> Void)

}

protocol MovieListCoordinatorProtocol: AnyObject, MovieDetailCoordinable {}

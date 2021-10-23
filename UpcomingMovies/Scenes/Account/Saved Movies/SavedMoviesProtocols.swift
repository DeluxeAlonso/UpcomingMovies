//
//  SavedMoviesProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol SavedMoviesViewModelProtocol {

    var displayTitle: String? { get set }

    var movieCells: [SavedMovieCellViewModelProtocol] { get }
    var needsPrefetch: Bool { get }

    var startLoading: Bindable<Bool> { get }
    var viewState: Bindable<SimpleViewState<Movie>> { get }

    func getCollectionList()
    func refreshCollectionList()

    func movie(at index: Int) -> Movie

}

protocol SavedMoviesInteractorProtocol {

    func getSavedMovies(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void)

}

protocol SavedMoviesCoordinatorProtocol: AnyObject {

    func showMovieDetail(for movie: Movie)

}

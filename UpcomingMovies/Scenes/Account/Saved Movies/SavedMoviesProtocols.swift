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

    var startLoading: AnyBehaviorBindable<Bool> { get }
    var viewState: AnyBehaviorBindable<SavedMoviesViewState> { get }

    func getCollectionList()
    func refreshCollectionList()

    func movie(at index: Int) -> MovieProtocol

}

protocol SavedMoviesInteractorProtocol {

    func getSavedMovies(page: Int?, completion: @escaping (Result<[MovieProtocol], Error>) -> Void)

}

protocol SavedMoviesCoordinatorProtocol: AnyObject, MovieDetailCoordinable {}

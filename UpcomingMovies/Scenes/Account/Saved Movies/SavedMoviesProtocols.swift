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
    
    var title: String? { get set }
    
    var movieCells: [SavedMovieCellViewModel] { get }
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

protocol SavedMoviesCoordinatorProtocol: Coordinator {
    
    func showMovieDetail(for movie: Movie)
    
}

extension SavedMoviesCoordinatorProtocol {
    
    func showMovieDetail(for movie: Movie) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        
        coordinator.movieInfo = .complete(movie: movie)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}

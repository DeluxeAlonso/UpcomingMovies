//
//  UpcomingMoviesProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol UpcomingMoviesViewModelProtocol {

    var viewState: AnyBehaviorBindable<SimpleViewState<Movie>> { get }
    var startLoading: AnyBehaviorBindable<Bool> { get }

    var movieCells: [UpcomingMovieCellViewModelProtocol] { get }
    var needsPrefetch: Bool { get }

    /**
     * Retrieves upcoming movies information.
     */
    func getMovies()

    /**
     * Retrieves upcoming movies information resetting the current page to zero.
     */
    func refreshMovies()

    func movie(for index: Int) -> Movie

}

protocol UpcomingMoviesCoordinatorProtocol: AnyObject {

    func showMovieDetail(for movie: Movie, with navigationConfiguration: UpcomingMoviesNavigationConfiguration?)

}

protocol UpcomingMoviesNavigationDelegate: UINavigationControllerDelegate {

    var parentCoordinator: Coordinator? { get set }

    func configure(selectedFrame: CGRect?, with imageToTransition: UIImage?)
    func updateOffset(_ verticalSafeAreaOffset: CGFloat)

}

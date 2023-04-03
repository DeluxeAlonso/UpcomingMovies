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

    var viewState: AnyBehaviorBindable<UpcomingMoviesViewState> { get }
    var startLoading: AnyBehaviorBindable<Bool> { get }
    var didUpdatePresentationMode: AnyPublishBindable<UpcomingMoviesPresentationMode> { get }

    var movieCells: [UpcomingMovieCellViewModelProtocol] { get }
    var needsPrefetch: Bool { get }

    var currentPresentationMode: UpcomingMoviesPresentationMode { get }

    /**
     * Retrieves upcoming movies information.
     */
    func getMovies()

    /**
     * Retrieves upcoming movies information resetting the current page to zero.
     */
    func refreshMovies()

    func movie(for index: Int) -> Movie

    func getToggleBarButtonItemModel() -> ToggleBarButtonItemViewModelProtocol

    func updatePresentationMode()

}

protocol UpcomingMoviesCoordinatorProtocol: AnyObject {

    func showMovieDetail(for movie: Movie, with navigationConfiguration: UpcomingMoviesNavigationConfiguration?)

}

protocol UpcomingMoviesNavigationDelegate: UINavigationControllerDelegate {

    var parentCoordinator: Coordinator? { get set }

    func configure(selectedFrame: CGRect?, with imageToTransition: UIImage?)
    func updateOffset(_ verticalSafeAreaOffset: CGFloat)

}

protocol UpcomingMoviesLayoutProviderProtocol {

    func collectionViewLayout(for presentationMode: UpcomingMoviesPresentationMode,
                              and width: CGFloat) -> UICollectionViewLayout

}

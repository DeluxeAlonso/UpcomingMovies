//
//  UpcomingMoviesProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol UpcomingMoviesViewModelProtocol: MoviesViewModel {
    
    var movieCells: [UpcomingMovieCellViewModel] { get }
    var needsPrefetch: Bool { get }
    
    func movie(for index: Int) -> Movie
    
}

protocol UpcomingMoviesCoordinatorProtocol: class {
    
    func showDetail(for movie: Movie, with navigationConfiguration: NavigationConfiguration?)
    
}

protocol UpcomingMoviesNavigationDelegate: class, UINavigationControllerDelegate {
    
    var parentCoordinator: Coordinator? { get set }
    
    func configure(selectedFrame: CGRect?, with imageToTransition: UIImage?)
    func updateOffset(_ verticalSafeAreaOffset: CGFloat)
    
}

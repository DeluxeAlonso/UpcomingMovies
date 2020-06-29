//
//  MovieDetailProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    
    var id: Int! { get set }
    var title: String! { get set }
    var genre: String? { get set }
    var releaseDate: String? { get set }
    var overview: String? { get set }
    var voteAverage: Double? { get set }
    var posterURL: URL? { get set }
    var backdropURL: URL? { get set }
    
    var updateMovieDetail: (() -> Void)? { get set }
    var needsFetch: Bool { get set }
    
    var options: [MovieDetailOption] { get }
    
    var startLoading: Bindable<Bool> { get }
    var isFavorite: Bindable<Bool?> { get }
    var showErrorView: Bindable<Error?> { get }
    var showGenreName: Bindable<String> { get }
    
    func getMovieDetail()
    func refreshMovieDetail()
    
    func saveVisitedMovie()
    func checkIfUserIsAuthenticated()
    func handleFavoriteMovie()
    
}

protocol MovieDetailCoordinatorProtocol: class {
    
    func showMovieVideos()
    func showMovieCredits()
    func showMovieReviews()
    func showSimilarMovies()
    
}

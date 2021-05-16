//
//  MovieDetailProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol MovieDetailViewModelProtocol {
    
    var id: Int! { get }
    var title: String! { get }
    var genre: String? { get }
    var releaseDate: String? { get }
    var overview: String? { get }
    var voteAverage: Double? { get }
    var posterURL: URL? { get }
    var backdropURL: URL? { get }

    var needsFetch: Bool { get }
    
    var startLoading: Bindable<Bool> { get }
    var isFavorite: Bindable<Bool?> { get }
    var showErrorView: Bindable<Error?> { get }
    var showGenreName: Bindable<String> { get }
    var showMovieOptions: Bindable<[MovieDetailOption]> { get }
    var didUpdateMovieDetail: Bindable<Bool> { get }
    var didUpdateFavoriteSuccess: Bindable<Bool> { get }
    var didUpdateFavoriteFailure: Bindable<Error?> { get }

    func getMovieDetail()
    func refreshMovieDetail()
    
    func saveVisitedMovie()
    func checkIfUserIsAuthenticated()
    func handleFavoriteMovie()
    
}

protocol MovieDetailInteractorProtocol {
    
    func isUserSignedIn() -> Bool
    
    func findGenre(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void)
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    
    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void)
    func isMovieInFavorites(for movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void)
    
    func saveMovieVisit(with id: Int, title: String, posterPath: String?)
    
}

protocol MovieDetailFactoryProtocol {
    
    var options: [MovieDetailOption] { get }
    
}

protocol MovieDetailCoordinatorProtocol: AnyObject {

    func showMovieOption(_ option: MovieDetailOption)
    func showSharingOptions(withShareTitle title: String)
    
}

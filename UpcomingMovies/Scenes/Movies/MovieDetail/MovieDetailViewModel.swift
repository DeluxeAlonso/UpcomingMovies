//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    private let interactor: MovieDetailInteractorProtocol
    
    var id: Int!
    var title: String!
    var genre: String?
    var releaseDate: String?
    var overview: String?
    var voteAverage: Double?
    var posterURL: URL?
    var backdropURL: URL?
    
    var updateMovieDetail: (() -> Void)?
    var needsFetch = false
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var isFavorite: Bindable<Bool?> = Bindable(false)
    var showErrorView: Bindable<Error?> = Bindable(nil)
    var showGenreName: Bindable<String> = Bindable("-")
    
    // MARK: - Initializers

    init(_ movie: Movie, interactor: MovieDetailInteractorProtocol) {
        self.interactor = interactor
        
        setupMovie(movie)
        checkIfUserIsAuthenticated()
    }
    
    init(id: Int, title: String, interactor: MovieDetailInteractorProtocol) {
        self.id = id
        self.title = title
        self.interactor = interactor
        
        self.needsFetch = true
    }
    
    // MARK: - Private
    
    private func setupMovie(_ movie: Movie) {
        id = movie.id
        title = movie.title
        
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        posterURL = movie.posterURL
        backdropURL = movie.backdropURL
        
        getMovieGenreName(for: movie.genreIds?.first)
        saveVisitedMovie()
    }
    
    private func getMovieGenreName(for genreId: Int?) {
        guard let genreId = genreId else { return }
        interactor.findGenre(with: genreId, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let genre):
                strongSelf.showGenreName.value = genre?.name ?? "-"
            case .failure:
                break
            }
        })
    }
    
    // MARK: - Networking
    
    func getMovieDetail() {
        fetchMovieDetail(showLoader: true)
    }
    
    func refreshMovieDetail() {
        fetchMovieDetail(showLoader: false)
    }
    
    private func fetchMovieDetail(showLoader: Bool = true) {
        guard needsFetch else { return }
        startLoading.value = showLoader
        interactor.getMovieDetail(for: id, completion: { result in
            switch result {
            case .success(let movie):
                self.setupMovie(movie)
                self.updateMovieDetail?()
                self.checkIfUserIsAuthenticated()
            case .failure(let error):
                self.startLoading.value = false
                self.showErrorView.value = error
            }
        })
    }
    
    func saveVisitedMovie() {
        interactor.saveMovieVisit(with: id, title: title, posterPath: posterURL?.absoluteString)
    }
    
    // MARK: - User Authentication
    
    func checkIfUserIsAuthenticated() {
        let isUserSignedIn = AuthenticationHandler.shared.isUserSignedIn()
        if isUserSignedIn {
            checkIfMovieIsFavorite()
        } else {
            startLoading.value = false
            isFavorite.value = nil
        }
    }
    
    // MARK: - Favorites
    
    private func checkIfMovieIsFavorite() {
        interactor.isMovieInFavorites(for: id, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let isFavorite):
                self.isFavorite.value = isFavorite
            case .failure(let error):
                guard self.needsFetch else { return }
                self.showErrorView.value = error
            }
        })
    }
    
    func handleFavoriteMovie() {
        guard let isFavorite = isFavorite.value else { return }
        interactor.markMovieAsFavorite(movieId: id, favorite: !isFavorite, completion: { result in
            switch result {
            case .success:
                self.isFavorite.value = !isFavorite
            case .failure(let error):
                self.showErrorView.value = error
            }
        })
    }
    
}

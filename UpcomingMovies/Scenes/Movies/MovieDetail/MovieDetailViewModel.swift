//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class MovieDetailViewModel {
    
    var id: Int
    var title: String
    var genre: String?
    var releaseDate: String
    var overview: String
    var voteAverage: Double?
    var posterPath: String?
    var posterURL: URL?
    var backdropPath: String?
    var backdropURL: URL?
    
    let isFavorite: Bindable<Bool> = Bindable(false)
    
    // MARK: - Initializers

    init(_ movie: Movie) {
        id = movie.id
        title = movie.title
        genre = movie.genreName
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        posterPath = movie.posterPath
        posterURL = movie.posterURL
        backdropPath = movie.backdropPath
        backdropURL = movie.backdropURL
    }
    
    // MARK: - Public
    
    func saveVisitedMovie() {
        PersistenceManager.shared.saveVisitedMovie(with: id,
                                                   title: title,
                                                   posterPath: posterPath)
    }
    
    // MARK: - Favorites
    
    func checkIfIsFavorite() {
        self.isFavorite.value = PersistenceManager.shared.isFavorite(for: self.id)
    }
    
    func handleFavoriteMovie() {
        let persistenceManager = PersistenceManager.shared
        if persistenceManager.isFavorite(for: self.id) {
            deleteFavoriteMovie()
            isFavorite.value = false
        } else {
            saveFavoriteMovie()
            isFavorite.value = true
        }
    }
    
    private func saveFavoriteMovie() {
        PersistenceManager.shared.saveFavorite(with: self.id,
                                              title: self.title,
                                              backdropPath: self.backdropPath)
    }
    
    private func deleteFavoriteMovie() {
        PersistenceManager.shared.removeFavorite(with: self.id)
    }
    
    // MARK: - View Models Building
    
    func buildVideosViewModel() -> MovieVideosViewModel {
        return MovieVideosViewModel(movieId: self.id, movieTitle: self.title)
    }
    
    func buildReviewsViewModel() -> MovieReviewsViewModel {
        return MovieReviewsViewModel(movieId: self.id, movieTitle: self.title)
    }
    
    func buildCreditsViewModel() -> MovieCreditsViewModel {
        return MovieCreditsViewModel(movieId: self.id, movieTitle: self.title)
    }
    
    func buildSimilarsViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .similar(movieId: self.id))
    }
    
}

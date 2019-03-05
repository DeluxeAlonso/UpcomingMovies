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
    
    var favoriteStore: PersistenceStore<Favorite>!
    var movieVisitStore: PersistenceStore<MovieVisit>!
    
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
        
        setupStores()
    }
    
    // MARK: - Private
    
    private func setupStores() {
        let managedObjectContext = PersistenceManager.shared.persistentContainer.viewContext
        favoriteStore = PersistenceStore(managedObjectContext)
        movieVisitStore = PersistenceStore(managedObjectContext)
    }
    
    // MARK: - Public
    
    func saveVisitedMovie() {
        movieVisitStore.saveMovieVisit(with: id, title: title, posterPath: posterPath)
    }
    
    // MARK: - Favorites
    
    func checkIfIsFavorite() {
        self.isFavorite.value = favoriteStore.exist(with: id)
    }
    
    func handleFavoriteMovie() {
        if favoriteStore.exist(with: id) {
            favoriteStore.removeFavorite(with: id)
            isFavorite.value = false
        } else {
            favoriteStore.saveFavorite(with: id,
                                       title: title,
                                       backdropPath: backdropPath)
            isFavorite.value = true
        }
    }
    
    // MARK: - View Models Building
    
    func buildVideosViewModel() -> MovieVideosViewModel {
        return MovieVideosViewModel(movieId: id, movieTitle: title)
    }
    
    func buildReviewsViewModel() -> MovieReviewsViewModel {
        return MovieReviewsViewModel(movieId: id, movieTitle: title)
    }
    
    func buildCreditsViewModel() -> MovieCreditsViewModel {
        return MovieCreditsViewModel(movieId: id, movieTitle: title)
    }
    
    func buildSimilarsViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .similar(movieId: id))
    }
    
}

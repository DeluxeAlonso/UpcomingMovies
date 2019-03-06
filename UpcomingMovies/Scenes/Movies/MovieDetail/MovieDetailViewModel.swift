//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class MovieDetailViewModel {
    
    private var managedObjectContext: NSManagedObjectContext
    private var favoriteStore: PersistenceStore<Favorite>!
    private var movieVisitStore: PersistenceStore<MovieVisit>!
    
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

    init(_ movie: Movie, managedObjectContext: NSManagedObjectContext) {
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
        
        self.managedObjectContext = managedObjectContext
        setupStores()
    }
    
    // MARK: - Private
    
    private func setupStores() {
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
        return MovieListViewModel(filter: .similar(movieId: id),
                                  managedObjectContext: managedObjectContext)
    }
    
}

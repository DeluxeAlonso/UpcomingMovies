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
    
    private var movieClient = MovieClient()
    
    var id: Int!
    var title: String!
    var genre: String?
    var releaseDate: String?
    var overview: String?
    var voteAverage: Double?
    var posterPath: String?
    var posterURL: URL?
    var backdropPath: String?
    var backdropURL: URL?
    
    var startLoading: ((Bool) -> Void)?
    var showErrorView: ((Error) -> Void)?
    var updateMovieDetail: (() -> Void)?
    var needsFetch = false
    var isFavorite: Bindable<Bool> = Bindable(false)
    
    // MARK: - Initializers

    init(_ movie: Movie, managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        setupMovie(movie)
        setupStores(self.managedObjectContext)
    }
    
    init(id: Int, title: String, managedObjectContext: NSManagedObjectContext) {
        self.id = id
        self.title = title
        self.managedObjectContext = managedObjectContext
        self.needsFetch = true
        setupStores(self.managedObjectContext)
    }
    
    // MARK: - Private
    
    private func setupMovie(_ movie: Movie) {
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
    
    private func setupStores(_ managedObjectContext: NSManagedObjectContext) {
        favoriteStore = PersistenceStore(managedObjectContext)
        movieVisitStore = PersistenceStore(managedObjectContext)
    }
    
    // MARK: - Public
    
    func getMovieDetail() {
        guard needsFetch else { return }
        startLoading?(true)
        movieClient.getMovieDetail(with: id, completion: { result in
            self.startLoading?(false)
            switch result {
            case .success(let movie):
                self.setupMovie(movie)
                self.updateMovieDetail?()
            case .failure(let error):
                self.showErrorView?(error)
            }
        })
    }
    
    func saveVisitedMovie() {
        movieVisitStore.saveMovieVisit(with: id,
                                       title: title,
                                       posterPath: posterPath)
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

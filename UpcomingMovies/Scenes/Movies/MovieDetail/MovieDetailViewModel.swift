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
    private var movieVisitStore: PersistenceStore<MovieVisit>!
    
    private var accountClient = AccountClient()
    private var movieClient = MovieClient()
    
    private var userCredentials = AuthenticationManager.shared.userCredentials()
    
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
    
    var showErrorView: Bindable<Error?> = Bindable(nil)
    var updateMovieDetail: (() -> Void)?
    var needsFetch = false
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var isFavorite: Bindable<Bool?> = Bindable(false)
    
    // MARK: - Initializers

    init(_ movie: Movie, managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        setupStores(self.managedObjectContext)
        setupMovie(movie)
        checkIfUserIsAuthenticated()
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
        saveVisitedMovie()
    }
    
    private func setupStores(_ managedObjectContext: NSManagedObjectContext) {
        movieVisitStore = PersistenceStore(managedObjectContext)
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
        movieClient.getMovieDetail(managedObjectContext,
                                   with: id, completion: { result in
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
        movieVisitStore.saveMovieVisit(with: id,
                                       title: title,
                                       posterPath: posterPath)
    }
    
    // MARK: - User Authentication
    
    func checkIfUserIsAuthenticated() {
        let isUserSignedIn = AuthenticationManager.shared.isUserSignedIn()
        if isUserSignedIn, let credentials = userCredentials {
            checkIfMovieIsFavorite(sessionId: credentials.sessionId)
        } else {
            startLoading.value = false
            isFavorite.value = nil
        }
    }
    
    // MARK: - Favorites
    
    func checkIfMovieIsFavorite(sessionId: String) {
        movieClient.getMovieAccountState(with: id, sessionId: sessionId, completion: { result  in
            self.startLoading.value = false
            switch result {
            case .success(let accountStateResult):
                guard let accountStateResult = accountStateResult else { return }
                self.isFavorite.value = accountStateResult.favorite
            case .failure(let error):
                guard self.needsFetch else { return }
                self.showErrorView.value = error
            }
        })
    }
    
    func handleFavoriteMovie() {
        guard let credentials = userCredentials,
            let isFavorite = isFavorite.value else {
                return
        }
        accountClient.markAsFavorite(id, sessionId: credentials.sessionId,
                                     accountId: credentials.accountId,
                                     favorite: !isFavorite, completion: { result  in
            switch result {
            case .success:
                self.isFavorite.value = !isFavorite
            case .failure(let error):
                self.showErrorView.value = error
            }
        })
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

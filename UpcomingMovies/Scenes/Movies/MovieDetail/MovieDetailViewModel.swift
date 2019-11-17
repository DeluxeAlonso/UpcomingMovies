//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieDetailViewModel {
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let movieUseCase: MovieUseCaseProtocol
    private let movieVisitUseCase: MovieVisitUseCaseProtocol
    private let genreUseCase: GenreUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol
    
    private var movieClient = MovieClient()
    
    private var authManager = AuthenticationManager.shared
    
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
    
    var updateMovieDetail: (() -> Void)?
    var needsFetch = false
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var isFavorite: Bindable<Bool?> = Bindable(false)
    var showErrorView: Bindable<Error?> = Bindable(nil)
    
    // MARK: - Initializers

    init(_ movie: Movie, useCaseProvider: UseCaseProviderProtocol) {
        self.useCaseProvider = useCaseProvider
        self.movieUseCase = self.useCaseProvider.movieUseCase()
        self.movieVisitUseCase = self.useCaseProvider.movieVisitUseCase()
        self.genreUseCase = self.useCaseProvider.genreUseCase()
        self.accountUseCase = self.useCaseProvider.accountUseCase()
        
        setupMovie(movie)
        checkIfUserIsAuthenticated()
    }
    
    init(id: Int, title: String, useCaseProvider: UseCaseProviderProtocol) {
        self.id = id
        self.title = title
        self.needsFetch = true
        
        self.useCaseProvider = useCaseProvider
        self.movieUseCase = self.useCaseProvider.movieUseCase()
        self.movieVisitUseCase = self.useCaseProvider.movieVisitUseCase()
        self.genreUseCase = self.useCaseProvider.genreUseCase()
        self.accountUseCase = self.useCaseProvider.accountUseCase()
    }
    
    // MARK: - Private
    
    private func setupMovie(_ movie: Movie) {
        id = movie.id
        title = movie.title
        
        if let genreId = movie.genreIds?.first {
            genre = genreUseCase.find(with: genreId)?.name ?? "-"
        }
        
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        posterPath = movie.posterPath
        posterURL = movie.posterURL
        backdropPath = movie.backdropPath
        backdropURL = movie.backdropURL
        
        saveVisitedMovie()
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
        movieUseCase.fetchMovieDetail(for: id, completion: { result in
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
        movieVisitUseCase.save(with: id, title: title, posterPath: posterPath)
    }
    
    // MARK: - User Authentication
    
    func checkIfUserIsAuthenticated() {
        let isUserSignedIn = AuthenticationManager.shared.isUserSignedIn()
        if isUserSignedIn, let credentials = authManager.userCredentials {
            checkIfMovieIsFavorite(sessionId: credentials.sessionId)
        } else {
            startLoading.value = false
            isFavorite.value = nil
        }
    }
    
    // MARK: - Favorites
    
    private func checkIfMovieIsFavorite(sessionId: String) {
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
        guard let credentials = authManager.userCredentials,
            let isFavorite = isFavorite.value else {
                return
        }
        accountUseCase.markMovieAsFavorite(movieId: id, favorite: !isFavorite, account: credentials, completion: { result in
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
        return MovieReviewsViewModel(movieId: id,
                                     movieTitle: title)
    }
    
    func buildCreditsViewModel() -> MovieCreditsViewModel {
        return MovieCreditsViewModel(movieId: id, movieTitle: title,
                                     useCaseProvider: useCaseProvider)
    }
    
    func buildSimilarsViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .similar(movieId: id),
                                  useCaseProvider: useCaseProvider)
    }
    
}

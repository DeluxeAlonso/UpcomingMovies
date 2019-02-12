//
//  MovieService.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

class MovieClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // MARK: - Movie list
    
    func getMovies(page: Int, filter: MovieListFilter, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request: URLRequest
        switch filter {
        case .upcoming:
            request = MovieProvider.getUpcoming(page: page).request
        case .popular:
            request = MovieProvider.getPopular(page: page).request
        case .topRated:
            request = MovieProvider.getTopRated(page: page).request
        case .byGenre(let genreId):
            request = MovieProvider.getByGenreId(page: page, genreId: genreId).request
        }
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    // MARK: - Movie search
    
    func searchMovies(searchText: String, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.search(searchText: searchText).request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    // MARK: - Movie detail
    
    func getMovieDetail(with movieId: Int, completion: @escaping (Result<Movie?, APIError>) -> Void) {
        fetch(with: MovieProvider.getDetail(id: movieId).request, decode: { json -> Movie? in
            guard let movie = json as? Movie else { return nil }
            return movie
        }, completion: completion)
    }
    
    // MARK: - Movie videos
    
    func getMovieVideos(with movieId: Int, completion: @escaping (Result<VideoResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.getVideos(id: movieId).request, decode: { json -> VideoResult? in
            guard let videoResult = json as? VideoResult else { return nil }
            return videoResult
        }, completion: completion)
    }
    
    // MARK: - Movie reviews
    
    func getMovieReviews(with movieId: Int, completion: @escaping (Result<ReviewResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.getReviews(id: movieId).request, decode: { json -> ReviewResult? in
            guard let reviewResult = json as? ReviewResult else { return nil }
            return reviewResult
        }, completion: completion)
    }
    
}

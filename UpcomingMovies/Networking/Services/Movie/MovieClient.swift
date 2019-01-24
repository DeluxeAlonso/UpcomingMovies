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
    
    func getUpcomingMovies(page: Int = 1, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.getUpcoming(page: page).request, decode: { json -> MovieResult? in
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
    
}

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
    
    func getUpcomingMovies(page: Int = 1,completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.getUpcoming(page: page).request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    func searchMovies(searchText: String, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.search(searchText: searchText).request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
}

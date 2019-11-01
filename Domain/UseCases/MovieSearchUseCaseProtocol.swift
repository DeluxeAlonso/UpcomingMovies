//
//  MovieSearchProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public protocol MovieSearchUseCaseProtocol {
    
    var didUpdateMovieSearch: (() -> Void)? { get set }
    
    func getMovieSearchs() -> [MovieSearch]
    func save(with searchText: String)
    
}

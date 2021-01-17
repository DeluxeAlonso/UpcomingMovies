//
//  MovieSearchProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public protocol MovieSearchUseCaseProtocol {
    
    var didUpdateMovieSearch: (() -> Void)? { get set }
    
    func getMovieSearches() -> [MovieSearch]
    func save(with searchText: String)
    
}

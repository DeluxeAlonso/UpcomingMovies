//
//  MovieSearchLocalDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public protocol MovieSearchLocalDataSourceProtocol {
    
    var didUpdateMovieSearch: (() -> Void)? { get set }
    
    func getMovieSearchs() -> [MovieSearch]
    func save(with searchText: String)
    
}

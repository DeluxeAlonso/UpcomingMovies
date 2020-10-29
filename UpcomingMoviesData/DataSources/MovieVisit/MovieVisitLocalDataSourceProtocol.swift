//
//  MovieVisitLocalDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public protocol MovieVisitLocalDataSourceProtocol {
    
    var didUpdateMovieVisit: (() -> Void)? { get set }
    
    func getMovieVisits() -> [MovieVisit]
    func save(with id: Int, title: String, posterPath: String?)
    func hasMovieVisits() -> Bool
    
}

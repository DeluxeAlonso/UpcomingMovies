//
//  GenreLocalDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public protocol GenreLocalDataSourceProtocol {
    
    var didUpdateGenre: (() -> Void)? { get set }
    
    func saveGenres(_ genres: [Genre])
    func find(with id: Int) -> Genre?
    func findAll() -> [Genre]
    
}

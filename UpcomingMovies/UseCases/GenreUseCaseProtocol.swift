//
//  GenreUseCaseProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol GenreUseCaseProtocol {
    
    var didUpdateGenre: (() -> Void)? { get set }
    
    func find(with id: Int) -> Genre?
    func findAll() -> [Genre]
    func saveGenres(_ genres: [Genre])
    
}

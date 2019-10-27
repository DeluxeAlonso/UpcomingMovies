//
//  PersistenceManager.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    static let shared = PersistenceManager()
    
    private var genreUseCase: GenreUseCaseProtocol

    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol = UseCaseProvider()) {
        genreUseCase = useCaseProvider.genreUseCase()
    }
    
    // MARK: - Movie Genres
    
    var genres: [Genre] {
        return genreUseCase.findAll()
    }
    
    func findGenre(with id: Int) -> Genre? {
        return genres.filter { $0.id == id }.first
    }
    
}

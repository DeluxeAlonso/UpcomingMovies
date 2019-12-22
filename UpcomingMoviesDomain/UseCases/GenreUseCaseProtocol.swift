//
//  GenreUseCaseProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public protocol GenreUseCaseProtocol {
    
    var didUpdateGenre: (() -> Void)? { get set }
    
    func find(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void)
    func fetchAll(completion: @escaping (Result<[Genre], Error>) -> Void)
    
}

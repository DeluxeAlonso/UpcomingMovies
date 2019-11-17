//
//  AccountUseCaseProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public protocol AccountUseCaseProtocol {
    
    func markMovieAsFavorite(movieId: Int,
                             favorite: Bool,
                             account: Account,
                             completion: @escaping (Result<Bool, Error>) -> Void)
    
}

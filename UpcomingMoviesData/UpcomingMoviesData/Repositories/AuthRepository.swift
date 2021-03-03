//
//  AuthRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public final class AuthRepository: AuthUseCaseProtocol {
    
    private var remoteDataSource: AuthRemoteDataSourceProtocol
    
    init(remoteDataSource: AuthRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getAuthURL(completion: @escaping (Result<URL, Error>) -> Void) {
        remoteDataSource.getAuthURL(completion: completion)
    }
    
    public func signInUser(completion: @escaping (Result<User, Error>) -> Void) {
        remoteDataSource.signInUser(completion: completion)
    }
    
    public func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.signOutUser(completion: completion)
    }
    
    public func currentUserId() -> Int? {
        return remoteDataSource.currentUserId()
    }
    
}

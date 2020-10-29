//
//  AuthUseCaseProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public protocol AuthUseCaseProtocol {
    
    func getAuthURL(completion: @escaping (Result<URL, Error>) -> Void)
    func signInUser(completion: @escaping (Result<User, Error>) -> Void)
    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void)
    func currentUserId() -> Int?
    
}

//
//  AuthenticationHandlerProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 15/03/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol AuthenticationHandlerProtocol {

    func currentUser() -> User?
    func isUserSignedIn() -> Bool
    func deleteCurrentUser()

}

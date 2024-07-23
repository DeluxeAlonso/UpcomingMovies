//
//  AuthenticationHandlerProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 15/03/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

protocol AuthenticationHandlerProtocol {

    func currentUser() -> UserProtocol?
    func isUserSignedIn() -> Bool
    func deleteCurrentUser()

}

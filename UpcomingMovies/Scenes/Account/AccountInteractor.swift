//
//  AccountInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/11/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class AccountInteractor: AccountInteractorProtocol {

    private let authHandler: AuthenticationHandlerProtocol

    init(authHandler: AuthenticationHandlerProtocol) {
        self.authHandler = authHandler
    }

    func currentUser() -> User? {
        authHandler.currentUser()
    }

}

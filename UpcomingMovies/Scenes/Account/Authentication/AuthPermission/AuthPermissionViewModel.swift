//
//  AuthPermissionViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class AuthPermissionViewModel: AuthPermissionViewModelProtocol {

    private let authPermissionURL: URL

    // MARK: - Initializers

    init(authPermissionURL: URL) {
        self.authPermissionURL = authPermissionURL
    }

    // MARK: - AuthPermissionViewModelProtocol

    var authPermissionURLRequest: URLRequest? {
        URLRequest(url: authPermissionURL)
    }

}

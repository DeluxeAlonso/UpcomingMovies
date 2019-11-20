//
//  AuthPermissionViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class AuthPermissionViewModel {

    var authPermissionURL: URL?
    
    init(authPermissionURL: URL?) {
        self.authPermissionURL = authPermissionURL
    }
    
}

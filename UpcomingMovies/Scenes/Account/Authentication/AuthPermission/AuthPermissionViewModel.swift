//
//  AuthPermissionViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class AuthPermissionViewModel {
    
    let requestToken: String
    
    var authPermissionURL: URL? {
        return URL(string: "https://www.themoviedb.org/auth/access?request_token=\(requestToken)")
    }
    
    init(requestToken: String) {
        self.requestToken = requestToken
    }
    
}

//
//  RequestToken.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct RequestToken: Decodable {
    
    let success: Bool
    let token: String?
    let expiresAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case success
        case token = "request_token"
        case expiresAt = "expires_at"
    }
    
}

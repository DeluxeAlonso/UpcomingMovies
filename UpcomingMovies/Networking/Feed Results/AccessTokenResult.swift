//
//  AccessTokenResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct AccessTokenResult: Decodable {
    
    let success: Bool
    let token: String
    
    private enum CodingKeys: String, CodingKey {
        case success
        case token = "access_token"
    }
    
}

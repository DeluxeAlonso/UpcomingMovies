//
//  Keys.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

/// Decodable Struct to retrieve the read access token and api key from a property list.
struct Keys: Decodable {
    
    let readAccessToken: String
    let apiKey: String
    
    private enum CodingKeys: String, CodingKey {
        case readAccessToken = "ReadAccessToken"
        case apiKey = "ApiKey"
    }
    
}

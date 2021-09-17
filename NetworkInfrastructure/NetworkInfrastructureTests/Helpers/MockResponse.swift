//
//  MockResponse.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 9/09/21.
//

import Foundation

enum MockResponse {
    case accessToken
    case requestToken
    case markAsFavorite
    case addToWatchlist
    case session
    case videos
    
    var jsonString: String {
        switch self {
        case .accessToken:
            return """
                {
                  "account_id": "4bc8892a017a3c0z92001001",
                  "access_token": "eyJhbGciOiJIUzI1NiIsInR"
                }
                """
        case .requestToken:
            return """
                {
                  "success": true,
                  "expires_at": "2016-08-26 17:04:39 UTC",
                  "request_token": "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd"
                }
                """
        case .markAsFavorite, .addToWatchlist:
            return """
                {
                    "status_code": 12,
                    "status_message": "The item/record was updated successfully."
                }
                """
        case .session:
            return """
                {
                  "success": true,
                  "session_id": "79191836ddaa0da3df76a5ffef6f07ad6ab0c641"
                }
                """
        case .videos:
            return """
            {
                  "iso_639_1": "en",
                  "iso_3166_1": "US",
                  "name": "Fight Club - Theatrical Trailer Remastered in HD",
                  "key": "6JnN1DmbqoU",
                  "site": "YouTube",
                  "size": 1080,
                  "type": "Trailer",
                  "official": false,
                  "published_at": "2015-02-26T03:19:25.000Z",
                  "id": "5e382d1b4ca676001453826d"
            }
            """
        }
    }
    
    var dataResponse: Data {
        Data(jsonString.utf8)
    }
    
}

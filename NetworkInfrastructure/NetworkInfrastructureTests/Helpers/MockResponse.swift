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
    case video
    case cast
    case crew
    
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
        case .video:
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
        case .cast:
            return """
                {
                  "adult": false,
                  "gender": 2,
                  "id": 819,
                  "known_for_department": "Acting",
                  "name": "Edward Norton",
                  "original_name": "Edward Norton",
                  "popularity": 7.861,
                  "profile_path": "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg",
                  "cast_id": 4,
                  "character": "The Narrator",
                  "credit_id": "52fe4250c3a36847f80149f3",
                  "order": 0
                }
                """
        case .crew:
            return """
                {
                  "adult": false,
                  "gender": 2,
                  "id": 376,
                  "known_for_department": "Production",
                  "name": "Arnon Milchan",
                  "original_name": "Arnon Milchan",
                  "popularity": 1.702,
                  "profile_path": "/b2hBExX4NnczNAnLuTBF4kmNhZm.jpg",
                  "credit_id": "55731b8192514111610027d7",
                  "department": "Production",
                  "job": "Executive Producer"
                }
                """
        }
    }
    
    var dataResponse: Data {
        Data(jsonString.utf8)
    }
    
}

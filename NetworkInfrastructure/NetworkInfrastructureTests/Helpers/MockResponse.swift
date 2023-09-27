//
//  MockResponse.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 9/09/21.
//

import Foundation

enum MockResponse {
    case accessToken
    case requestTokenResult
    case markAsFavorite
    case addToWatchlist
    case rateMovie
    case sessionResult
    case video
    case cast
    case crew
    case review
    case genre
    case imageConfiguration
    case movieResult
    case listResult

    var jsonString: String {
        switch self {
        case .accessToken:
            return """
                {
                  "account_id": "4bc8892a017a3c0z92001001",
                  "access_token": "eyJhbGciOiJIUzI1NiIsInR"
                }
                """
        case .requestTokenResult:
            return """
                {
                  "success": true,
                  "expires_at": "2016-08-26 17:04:39 UTC",
                  "request_token": "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd"
                }
                """
        case .markAsFavorite, .addToWatchlist, .rateMovie:
            return """
                {
                    "status_code": 12,
                    "status_message": "The item/record was updated successfully."
                }
                """
        case .sessionResult:
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
        case .review:
            return """
                {
                  "author": "Cat Ellington",
                  "author_details": {
                    "name": "Cat Ellington",
                    "username": "CatEllington",
                    "avatar_path": "/uCmwgSbJAcHqNwSvQvTv2dB95tx.jpg",
                    "rating": null
                  },
                  "content": "(As I'm writing this review, Darth Vader's theme music begins to build in my mind...)",
                  "created_at": "2017-02-13T22:23:01.268Z",
                  "id": "58a231c5925141179e000674",
                  "updated_at": "2017-02-13T23:16:19.538Z",
                  "url": "https://www.themoviedb.org/review/58a231c5925141179e000674"
                }
                """
        case .genre:
            return """
                {
                  "id": 12345,
                  "name": "Adventure"
                }
                """
        case .imageConfiguration:
            return """
                {
                  "base_url": "http://image.tmdb.org/t/p/",
                  "secure_base_url": "https://image.tmdb.org/t/p/",
                  "backdrop_sizes": [
                  "w300",
                  "w780",
                  "w1280",
                  "original"
                  ],
                  "poster_sizes": [
                  "w92",
                  "w154",
                  "w185",
                  "w342",
                  "w500",
                  "w780",
                  "original"
                  ]
                }
                """
        case .movieResult:
            return """
                {
                  "results": [
                    {
                      "id": 1,
                      "title": "Title",
                      "overview": "Overview"
                    }
                  ],
                  "page": 1,
                  "total_pages": 1
                }
                """
        case .listResult:
            return """
                {
                  "results": [
                    {
                      "id": 1,
                      "name": "List Name",
                      "number_of_items": 2
                    }
                  ],
                  "page": 1,
                  "total_pages": 1
                }
                """
        }
    }

    var dataResponse: Data {
        Data(jsonString.utf8)
    }

}

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
    case videoResult
    case creditResult
    case cast
    case crew
    case review
    case reviewResult
    case genre
    case genreResult
    case imageConfiguration
    case movieResult
    case movieDetailResult
    case list
    case listResult
    case user
    case accountStateResult

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
        case .videoResult:
            return """
                {
                    "results": [
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
                    ]
                }
                """
        case .creditResult:
            return """
                {
                    "id": 238,
                    "cast": [
                        {
                            "adult": false,
                            "gender": 2,
                            "id": 3084,
                            "known_for_department": "Acting",
                            "name": "Marlon Brando",
                            "original_name": "Marlon Brando",
                            "popularity": 19.922,
                            "profile_path": "/eEHCjqKMWSvQU4bmwhLMsg4RtEr.jpg",
                            "cast_id": 146,
                            "character": "Don Vito Corleone",
                            "credit_id": "6489aa85e2726001072483a9",
                            "order": 0
                        }
                    ],
                    "crew": [
                        {
                            "adult": false,
                            "gender": 2,
                            "id": 154,
                            "known_for_department": "Editing",
                            "name": "Walter Murch",
                            "original_name": "Walter Murch",
                            "popularity": 3.867,
                            "profile_path": "/kQh7U7kRLF9NKEMpxiGjZEIu0o3.jpg",
                            "credit_id": "62bd43fb63d9370092ba09da",
                            "department": "Crew",
                            "job": "Post Production Consulting"
                        }
                    ]
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
        case .reviewResult:
            return """
                {
                  "results": [
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
                  ],
                  "page": 1,
                  "total_pages": 1
                }
            """
        case .genre:
            return """
                {
                  "id": 12345,
                  "name": "Adventure"
                }
                """
        case .genreResult:
            return """
                {
                    "genres: {
                      "id": 12345,
                      "name": "Adventure"
                    }
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
        case .movieDetailResult:
            return """
                {
                  "adult": false,
                  "backdrop_path": "/r7DuyYJ0N3cD8bRKsR5Ygq2P7oa.jpg",
                  "belongs_to_collection": null,
                  "budget": 60000000,
                  "genres": [
                    {
                      "id": 12,
                      "name": "Adventure"
                    },
                    {
                      "id": 28,
                      "name": "Action"
                    },
                    {
                      "id": 18,
                      "name": "Drama"
                    }
                  ],
                  "homepage": "https://www.granturismo.movie",
                  "id": 980489,
                  "imdb_id": "tt4495098",
                  "original_language": "en",
                  "original_title": "Gran Turismo",
                  "overview": "The ultimate wish-fulfillment",
                  "popularity": 2320.595,
                  "poster_path": "/51tqzRtKMMZEYUpSYkrUE7v9ehm.jpg",
                  "production_companies": [
                    {
                      "id": 125281,
                      "logo_path": "/3hV8pyxzAJgEjiSYVv1WZ0ZYayp.png",
                      "name": "PlayStation Productions",
                      "origin_country": "US"
                    },
                    {
                      "id": 84792,
                      "logo_path": "/7Rfr3Zu6QnHpXW2VdSEzUminAQd.png",
                      "name": "2.0 Entertainment",
                      "origin_country": "US"
                    },
                    {
                      "id": 5,
                      "logo_path": "/wrweLpBqRYcAM7kCSaHDJRxKGOP.png",
                      "name": "Columbia Pictures",
                      "origin_country": "US"
                    }
                  ],
                  "production_countries": [
                    {
                      "iso_3166_1": "US",
                      "name": "United States of America"
                    }
                  ],
                  "release_date": "2023-08-09",
                  "revenue": 114800000,
                  "runtime": 135,
                  "spoken_languages": [
                    {
                      "english_name": "English",
                      "iso_639_1": "en",
                      "name": "English"
                    },
                    {
                      "english_name": "German",
                      "iso_639_1": "de",
                      "name": "Deutsch"
                    },
                    {
                      "english_name": "Japanese",
                      "iso_639_1": "ja",
                      "name": "日本語"
                    }
                  ],
                  "status": "Released",
                  "tagline": "From gamer to racer.",
                  "title": "Gran Turismo",
                  "video": false,
                  "vote_average": 8.023,
                  "vote_count": 884
                }
            """
        case .list:
            return """
                {
                  "account_object_id": "5c490f9ac3a368477789f631",
                  "adult": 0,
                  "average_rating": 8.1,
                  "backdrop_path": "/tYjyk4Ij7CwVOn2ovcXdRYffR9k.jpg",
                  "created_at": "2019-04-20 07:10:32 UTC",
                  "description": "List with all the Godfather films",
                  "featured": 0,
                  "id": 110115,
                  "iso_3166_1": "US",
                  "iso_639_1": "en",
                  "name": "The Godfather Movies",
                  "number_of_items": 5,
                  "poster_path": null,
                  "public": 1,
                  "revenue": 484432473,
                  "runtime": "1217",
                  "sort_by": 1,
                  "updated_at": "2020-05-10 20:35:32 UTC"
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
        case .user:
            return """
                {
                  "avatar": {
                    "gravatar": {
                      "hash": "a4f7b0f48f9bc68bcbef1e0e6ce2d882"
                    },
                    "tmdb": {
                      "avatar_path": "/5JoRQ9PxchAI4yEaWIUVoBUk5uI.jpg"
                    }
                  },
                  "id": 12345,
                  "iso_639_1": "en",
                  "iso_3166_1": "PE",
                  "name": "Alonso Alvarez",
                  "include_adult": false,
                  "username": "DeluxeAlonso"
                }
                """
        case .accountStateResult:
            return """
                {
                  "id": 575264,
                  "favorite": false,
                  "rated": false,
                  "watchlist": false
                }
                """
        }
    }

    var dataResponse: Data {
        Data(jsonString.utf8)
    }

}

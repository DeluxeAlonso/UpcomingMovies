//
//  BaseConfiguration.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

struct BaseConfiguration: Decodable {

    struct Keys: Decodable {

        let readAccessToken: String
        let apiKey: String

        private enum CodingKeys: String, CodingKey {
            case readAccessToken = "ReadAccessToken"
            case apiKey = "ApiKey"
        }

    }

    let keys: Keys

    private enum CodingKeys: String, CodingKey {
        case keys = "TheMovieDb"
    }

}

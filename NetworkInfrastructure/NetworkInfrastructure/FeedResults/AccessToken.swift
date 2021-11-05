//
//  AccessToken.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

struct AccessToken: Decodable {

    let token: String
    let accountId: String

    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case accountId = "account_id"
    }

}

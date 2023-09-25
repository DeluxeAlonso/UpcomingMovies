//
//  RequestTokenResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

struct RequestTokenResult: Decodable {

    let success: Bool
    let token: String

    private enum CodingKeys: String, CodingKey {
        case success
        case token = "request_token"
    }

}

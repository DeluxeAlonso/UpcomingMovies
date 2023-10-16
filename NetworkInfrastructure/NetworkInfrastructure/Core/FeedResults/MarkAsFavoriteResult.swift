//
//  MarkAsFavoriteResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

struct MarkAsFavoriteResult: Decodable {

    let statusCode: Int
    let statusMessage: String

    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }

}

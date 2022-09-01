//
//  RateMovieResult.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 3/06/21.
//

struct RateMovieResult: Decodable {

    let statusCode: Int
    let statusMessage: String

    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }

}

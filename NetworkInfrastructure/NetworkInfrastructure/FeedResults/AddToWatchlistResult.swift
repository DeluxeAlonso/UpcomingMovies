//
//  AddToWatchlistResult.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 6/09/21.
//

struct AddToWatchlistResult: Decodable {

    let statusCode: Int
    let statusMessage: String

    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }

}

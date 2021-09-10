//
//  MockResponse.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 9/09/21.
//

import Foundation

enum MockResponse {
    case accessToken

    var jsonString: String {
        switch self {
        case .accessToken:
            return """
                {
                  "account_id": "4bc8892a017a3c0z92001001",
                  "access_token": "eyJhbGciOiJIUzI1NiIsInR"
                }
                """
        }
    }

    var dataResponse: Data {
        Data(jsonString.utf8)
    }

}

//
//  NetworkConfiguration.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 2/3/21.
//

import Foundation

final class NetworkConfiguration {

    static let shared = NetworkConfiguration()

    private (set) var apiKey = ""
    private (set) var readAccessToken = ""

    var baseAPIURLString: String {
        return "https://api.themoviedb.org"
    }

    init() {}

    func configure(with apiKey: String, and readAccessToken: String) {
        self.apiKey = apiKey
        self.readAccessToken = readAccessToken
    }

}

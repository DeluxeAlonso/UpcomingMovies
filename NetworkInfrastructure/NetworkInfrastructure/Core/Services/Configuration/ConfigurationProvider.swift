//
//  ConfigurationProvider.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

enum ConfigurationProvider {

    case getAPIConfiguration

}

// MARK: - Endpoint

extension ConfigurationProvider: Endpoint {

    var base: String {
        NetworkConfiguration.shared.baseAPIURLString
    }

    var path: String {
        switch self {
        case .getAPIConfiguration:
            return "/3/configuration"
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getAPIConfiguration:
            return nil
        }
    }

    var params: [String: Any]? {
        switch self {
        case .getAPIConfiguration:
            return nil
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getAPIConfiguration:
            return .defaultEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getAPIConfiguration:
            return .get
        }
    }

}

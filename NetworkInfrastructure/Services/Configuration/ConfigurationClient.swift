//
//  ConfigurationClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class ConfigurationClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getAPIConfiguration(completion: @escaping (Result<Configuration, APIError>) -> Void) {
        fetch(with: ConfigurationProvider.getAPIConfiguration.request, decode: { json -> Configuration? in
            guard let configuration = json as? Configuration else { return nil }
            return configuration
        }, completion: completion)
    }
}

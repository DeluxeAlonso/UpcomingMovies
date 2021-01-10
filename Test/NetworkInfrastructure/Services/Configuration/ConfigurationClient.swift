//
//  ConfigurationClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

class ConfigurationClient: APIClient, ConfigurationClientProtocol {

    let session: URLSession

    // MARK: - Initializers
    
    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }

    // MARK: - ConfigurationClientProtocol
    
    func getImagesConfiguration(completion: @escaping (Result<ImagesConfigurationResult, APIError>) -> Void) {
        fetch(with: ConfigurationProvider.getAPIConfiguration.request, decode: { json -> ImagesConfigurationResult? in
            guard let configuration = json as? ImagesConfigurationResult else { return nil }
            return configuration
        }, completion: completion)
    }
    
}

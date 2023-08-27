//
//  ConfigurationClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

final class ConfigurationClient: APIClient, ConfigurationClientProtocol {

    let session: URLSession

    // MARK: - Initializers

    init(session: URLSession) {
        self.session = session
    }

    convenience init() {
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        self.init(session: session)
    }

    // MARK: - ConfigurationClientProtocol

    func getImagesConfiguration(completion: @escaping (Result<ImagesConfigurationResult, APIError>) -> Void) {
        fetch(with: ConfigurationProvider.getAPIConfiguration.request, decode: { json -> ImagesConfigurationResult? in
            guard let configuration = json as? ImagesConfigurationResult else { return nil }
            return configuration
        }, completion: completion)
    }

}

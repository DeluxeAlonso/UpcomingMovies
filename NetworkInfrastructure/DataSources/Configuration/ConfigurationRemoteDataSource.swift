//
//  ConfigurationRemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import UpcomingMoviesData

final class ConfigurationRemoteDataSource: ConfigurationRemoteDataSourceProtocol {
    
    private let client: ConfigurationClient
    
    init(client: ConfigurationClient) {
        self.client = client
    }
    
    func getConfiguration(completion: @escaping (Result<UpcomingMoviesDomain.Configuration, Error>) -> Void) {
        client.getImagesConfiguration { result in
            switch result {
            case .success(let configurationResult):
                let configuration = Configuration(imagesConfiguration: configurationResult)
                completion(.success(configuration.asDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

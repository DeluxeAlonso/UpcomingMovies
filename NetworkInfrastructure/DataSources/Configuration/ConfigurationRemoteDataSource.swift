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
        client.getAPIConfiguration { result in
            switch result {
            case .success(let configuration):
                completion(.success(configuration.asDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

//
//  ConfigurationRemoteDataSourceProtocolMock.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 25/06/22.
//

import UpcomingMoviesDomain

final class ConfigurationRemoteDataSourceProtocolMock: ConfigurationRemoteDataSourceProtocol {

    var getConfigurationResult: Result<Configuration, Error>?
    private(set) var getConfigurationCallCount = 0
    func getConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void) {
        if let getConfigurationResult = getConfigurationResult {
            completion(getConfigurationResult)
        }
        getConfigurationCallCount += 1
    }

}

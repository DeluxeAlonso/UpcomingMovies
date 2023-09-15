//
//  ConfigurationClientProtocolMock.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 15/09/23.
//

import UpcomingMoviesDomain

final class ConfigurationClientProtocolMock: ConfigurationClientProtocol {

    var getImagesConfigurationResult: Result<ImagesConfigurationResult, APIError>?
    private(set) var getImagesConfigurationCallCount = 0
    func getImagesConfiguration(completion: @escaping (Result<ImagesConfigurationResult, APIError>) -> Void) {
        if let getImagesConfigurationResult = getImagesConfigurationResult {
            completion(getImagesConfigurationResult)
        }
        getImagesConfigurationCallCount += 1
    }

}

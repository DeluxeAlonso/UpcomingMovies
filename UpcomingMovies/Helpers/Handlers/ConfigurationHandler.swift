//
//  ConfigurationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ConfigurationHandlerProtocol {
    
    var regularImageBaseURLString: String { get }
    var backdropImageBaseURLString: String { get }
    
    func getAppConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void)
    
}

class ConfigurationHandler: ConfigurationHandlerProtocol {
    
    private let configurationUseCase: ConfigurationUseCaseProtocol
    
    private var imageConfiguration: ImageConfigurationHandler?
    
    // MARK: - Initializarerz
    
    init(configurationUseCase: ConfigurationUseCaseProtocol) {
        self.configurationUseCase = configurationUseCase
    }
    
    // MARK: - ConfigurationHandlerProtocol
    
    var regularImageBaseURLString: String {
        guard !isTesting() else {
            return ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString
        }
        return imageConfiguration?.regularImageBaseURLString ?? ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString
    }
    
    var backdropImageBaseURLString: String {
        guard !isTesting() else {
            return ImageConfigurationHandler.Constants.defaultBackdropImageBaseURLString
        }
        return imageConfiguration?.backdropImageBaseURLString ??  ImageConfigurationHandler.Constants.defaultBackdropImageBaseURLString
    }
    
    func getAppConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void) {
        configurationUseCase.getConfiguration { result in
            switch result {
            case .success(let configuration):
                self.setConfiguration(configuration)
                completion(.success(configuration))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func setConfiguration(_ configuration: Configuration) {
        self.imageConfiguration = ImageConfigurationHandler(configuration: configuration)
    }
    
    // MARK: - XCTest
    
    private func isTesting() -> Bool {
        return NSClassFromString("XCTest") != nil
    }
    
}

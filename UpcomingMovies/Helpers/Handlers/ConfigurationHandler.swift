//
//  ConfigurationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class ConfigurationHandler {
    
    static let shared: ConfigurationHandler = ConfigurationHandler()
    
    private var imageConfiguration: ImageConfigurationHandler!
    
    init() {}
    
    func setConfiguration(_ configuration: Configuration) {
        self.imageConfiguration = ImageConfigurationHandler(configuration: configuration)
    }
    
    // MARK: - Images Configuration
    
    var regularImageBaseURLString: String {
        guard !isTesting else {
            return ImageConfigurationHandler.Constants.mockRegularImageBaseURLString
        }
        return imageConfiguration.regularImageBaseURLString
    }
    
    var backdropImageBaseURLString: String {
        guard !isTesting else {
            return ImageConfigurationHandler.Constants.mockBackdropImageBaseURLString
        }
        return imageConfiguration.backdropImageBaseURLString
    }
    
    // MARK: - XCTest
    
    var isTesting: Bool {
        return NSClassFromString("XCTest") != nil
    }
    
}

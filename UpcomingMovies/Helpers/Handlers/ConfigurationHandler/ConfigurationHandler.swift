//
//  ConfigurationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class ConfigurationHandler: ConfigurationHandlerProtocol {

    private var imageConfiguration: ImageConfigurationHandlerProtocol?

    // MARK: - ConfigurationHandlerProtocol

    var regularImageBaseURLString: String {
//        guard !isTesting() else {
//            return ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString
//        }
        return imageConfiguration?.regularImageBaseURLString ?? ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString
    }

    var backdropImageBaseURLString: String {
//        guard !isTesting() else {
//            return ImageConfigurationHandler.Constants.defaultBackdropImageBaseURLString
//        }
        return imageConfiguration?.backdropImageBaseURLString ??  ImageConfigurationHandler.Constants.defaultBackdropImageBaseURLString
    }

    var avatarImageBaseURLString: String? {
        imageConfiguration?.avatarImageBaseURLString
    }

    func setConfiguration(_ configuration: Configuration) {
        self.imageConfiguration = ImageConfigurationHandler(configuration: configuration)
    }

}

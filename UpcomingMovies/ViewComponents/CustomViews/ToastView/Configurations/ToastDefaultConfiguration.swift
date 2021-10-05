//
//  ToastDefaultConfiguration.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

enum ToastDefaultConfiguration {

    case success
    case failure

    var configuration: ToastConfigurationProtocol {
        switch self {
        case .success:
            return ToastSuccessConfiguration.shared
        case .failure:
            return ToastFailureConfiguration.shared
        }
    }

}

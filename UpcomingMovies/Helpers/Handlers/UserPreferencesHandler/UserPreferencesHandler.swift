//
//  UserPreferencesHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

final class UserPreferencesHandler: UserPreferencesHandlerProtocol {

    @UserDefaultsStorage(key: "UpcomingMoviesDisplayMode", defaultValue: 0)
    private var upcomingMoviesDisplayModeRawValue: Int

    var upcomingMoviesDisplayMode: UpcomingMoviesDisplayMode {
        get {
            UpcomingMoviesDisplayMode(rawValue: upcomingMoviesDisplayModeRawValue) ?? .preview
        }
        set {
            upcomingMoviesDisplayModeRawValue = newValue.rawValue
        }
    }

}

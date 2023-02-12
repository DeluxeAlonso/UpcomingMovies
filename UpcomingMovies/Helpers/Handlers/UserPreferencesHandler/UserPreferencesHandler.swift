//
//  UserPreferencesHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

final class UserPreferencesHandler: UserPreferencesHandlerProtocol {

    @UserDefaultsStorage(key: "UpcomingMoviesPresentationMode", defaultValue: 0)
    private var upcomingMoviesPresentationModeRawValue: Int

    var upcomingMoviesPresentationMode: UpcomingMoviesPresentationMode {
        get {
            UpcomingMoviesPresentationMode(rawValue: upcomingMoviesPresentationModeRawValue) ?? .preview
        }
        set {
            upcomingMoviesPresentationModeRawValue = newValue.rawValue
        }
    }

}

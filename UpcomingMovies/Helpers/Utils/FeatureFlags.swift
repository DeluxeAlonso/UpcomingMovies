//
//  FeatureFlags.swift
//  UpcomingMovies
//
//  Created by Alonso on 18/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

final class FeatureFlags {

    static let shared = FeatureFlags()

    init() {}

    var showRedesignedMovieDetailScreen = false

}

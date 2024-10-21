//
//  AppExtension.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/26/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

struct AppExtension {

    static let scheme = "upcomingmovies"

    static func url(for host: DeepLinkDestination) -> URL? {
        let urlString = scheme + "://" + host.rawValue
        return URL(string: urlString)
    }

}

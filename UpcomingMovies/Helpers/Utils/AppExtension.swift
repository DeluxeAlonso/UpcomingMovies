//
//  AppExtension.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/26/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

struct AppExtension {

    static let scheme = "extension"

    enum Host: String {

        case upcomingMovies = "upcoming"
        case searchMovies = "search"

    }

    static func url(for host: AppExtension.Host) -> URL? {
        let urlString = scheme + "://" + host.rawValue
        return URL(string: urlString)
    }

}

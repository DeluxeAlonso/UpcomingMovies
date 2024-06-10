//
//  MockVideoProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 9/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockVideoProtocol: VideoProtocol {

    var id: String
    var key: String
    var name: String
    var site: String
    var browserURL: URL?
    var deepLinkURL: URL?
    var thumbnailURL: URL?

    init(id: String = "",
         key: String = "",
         name: String = "",
         site: String = "",
         browserURL: URL? = nil,
         deepLinkURL: URL? = nil,
         thumbnailURL: URL? = nil) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
        self.browserURL = browserURL
        self.deepLinkURL = deepLinkURL
        self.thumbnailURL = thumbnailURL
    }

}

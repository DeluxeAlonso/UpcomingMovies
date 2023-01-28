//
//  Video.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public struct Video {

    public let id: String
    public let key: String
    public let name: String
    public let site: String
    public let browserURL: URL?
    public let deepLinkURL: URL?
    public let thumbnailURL: URL?

    public init(id: String, key: String, name: String, site: String,
                browserURL: URL?, deepLinkURL: URL?, thumbnailURL: URL?) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
        self.browserURL = browserURL
        self.deepLinkURL = deepLinkURL
        self.thumbnailURL = thumbnailURL
    }

}

extension Video: Equatable {

    public static func == (lhs: Video, rhs: Video) -> Bool {
        lhs.id == rhs.id
    }

}

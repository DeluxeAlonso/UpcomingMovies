//
//  VideoProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 18/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol VideoProtocol {

    var id: String { get }
    var key: String { get }
    var name: String { get }
    var site: String { get }
    var browserURL: URL? { get }
    var deepLinkURL: URL? { get }
    var thumbnailURL: URL? { get }

}

struct VideoModel: VideoProtocol {

    let id: String
    let key: String
    let name: String
    let site: String
    let browserURL: URL?
    let deepLinkURL: URL?
    let thumbnailURL: URL?

    init(_ video: Video) {
        self.id = video.id
        self.key = video.key
        self.name = video.name
        self.site = video.site
        self.browserURL = video.browserURL
        self.deepLinkURL = video.deepLinkURL
        self.thumbnailURL = video.thumbnailURL
    }
}

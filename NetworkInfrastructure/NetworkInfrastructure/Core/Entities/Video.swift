//
//  Video.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct Video: Decodable {

    let id: String
    let key: String
    let name: String
    let site: String

}

extension Video {

    var browserURL: URL? {
        URL(string: "https://www.youtube.com/watch?v=\(key)")
    }

    var deepLinkURL: URL? {
        URL(string: "youtube://\(key)")
    }

    var thumbnailURL: URL? {
        URL(string: "https://img.youtube.com/vi/\(key)/mqdefault.jpg")
    }

}

extension Video: DomainConvertible {

    func asDomain() -> UpcomingMoviesDomain.Video {
        UpcomingMoviesDomain.Video(id: id, key: key, name: name, site: site,
                                   browserURL: browserURL, deepLinkURL: deepLinkURL, thumbnailURL: thumbnailURL)
    }

}

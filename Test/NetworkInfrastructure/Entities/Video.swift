//
//  Video.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public struct Video: Decodable {
    
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    
}

extension Video {
    
    public var browserURL: URL? {
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
    
    public var deepLinkURL: URL? {
        return URL(string: "youtube://\(key)")
    }
    
    public var thumbnailURL: URL? {
        return URL(string: "https://img.youtube.com/vi/\(key)/mqdefault.jpg")
    }
    
}

extension Video: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.Video {
        return UpcomingMoviesDomain.Video(id: id, key: key, name: name, site: site,
                                          browserURL: browserURL, deepLinkURL: deepLinkURL, thumbnailURL: thumbnailURL)
    }
    
}

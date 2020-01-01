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
        return lhs.id == rhs.id
    }
    
}

// MARK: - Test mockups

extension Video {
    
    static func with(id: String = "1",
                     key: String = "ABC",
                     name: String = "Video1",
                     site: String = "youtube123",
                     browserURL: URL? = URL(string: "https://www.youtube.com/watch?v=ABC"),
                     deepLinkURL: URL? = URL(string: "youtube://ABC"),
                     thumnailURL: URL? = URL(string: "https://img.youtube.com/vi/ABC/mqdefault.jpg")) -> Video {
        return Video(id: id, key: key, name: name, site: site,
                     browserURL: browserURL, deepLinkURL: deepLinkURL, thumbnailURL: thumnailURL)
    }
    
}

//
//  Video.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

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
                     site: String = "youtube123" ) -> Video {
        return Video(id: id, key: key, name: name, site: site)
    }
    
}

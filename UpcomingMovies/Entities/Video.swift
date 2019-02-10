//
//  Video.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct Video: Decodable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
}

extension Video {
    
    var browserURL: URL? {
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
    
    var deepLinkURL: URL? {
        return URL(string: "youtube://\(key)")
    }
    
    var thumbnailURL: URL? {
        return URL(string: "https://img.youtube.com/vi/\(key)/mqdefault.jpg")
    }
    
}

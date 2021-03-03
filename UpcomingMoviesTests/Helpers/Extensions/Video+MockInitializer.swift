//
//  Video+MockInitializer.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/5/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

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

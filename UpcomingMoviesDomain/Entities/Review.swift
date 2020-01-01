//
//  Review.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public struct Review: Equatable {
    
    public let id: String
    public let authorName: String
    public let content: String
    
    public init(id: String, authorName: String, content: String) {
        self.id = id
        self.authorName = authorName
        self.content = content
    }
    
}

// MARK: - Test mockups

extension Review {
    
    static func with(id: String = "1",
                     authorName: String = "ABC",
                     content: String = "Video1") -> Review {
        return Review(id: id, authorName: authorName, content: content)
    }
    
}

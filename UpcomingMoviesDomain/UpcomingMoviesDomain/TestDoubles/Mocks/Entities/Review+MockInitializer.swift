//
//  Review+MockInitializer.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/7/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

public extension Review {

    static func with(id: String = "1",
                     authorName: String = "ABC",
                     content: String = "Video1") -> Review {
        Review(id: id, authorName: authorName, content: content)
    }

}

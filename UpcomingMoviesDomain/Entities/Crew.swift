//
//  Crew.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public struct Crew {
    
    public let id: Int
    public let job: String
    public let name: String
    public let profileURL: URL?

    public init(id: Int, job: String, name: String, profileURL: URL?) {
        self.id = id
        self.job = job
        self.name = name
        self.profileURL = profileURL
    }
    
}

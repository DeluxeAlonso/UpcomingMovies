//
//  Review.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public struct Review: Decodable {
    
    public let id: String
    public let authorName: String
    public let content: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case authorName = "author"
        case content
    }
    
}

extension Review: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.Review {
        return UpcomingMoviesDomain.Review(id: id, authorName: authorName, content: content)
    }
    
}

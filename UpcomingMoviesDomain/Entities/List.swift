//
//  List.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public struct List: Decodable, Equatable {
    
    public let id: String
    public let name: String
    public let description: String?
    public let backdropPath: String?
    public let averageRating: Double?
    public let runtime: Int?
    public let movieCount: Int
    public let movies: [Movie]?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, runtime
        case backdropPath = "backdrop_path"
        case averageRating = "average_rating"
        case movieCount = "number_of_items"
        case movies = "items"
    }
    
    // MARK: - Initializer
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Id key can be either an Int or a String
        if let id = try? container.decode(Int.self, forKey: .id) {
            self.id = String(id)
        } else {
            self.id = try container.decode(String.self, forKey: .id)
        }
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try? container.decode(String.self, forKey: .description)
        self.backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        self.averageRating = try? container.decode(Double.self, forKey: .averageRating)
        self.runtime = try? container.decode(Int.self, forKey: .runtime)
        self.movieCount = try container.decode(Int.self, forKey: .movieCount)
        self.movies = try? container.decode([Movie].self, forKey: .movies)
    }
    
}

// MARK: - Computed Properties

extension List {

    public var backdropURL: URL? {
        guard let posterPath = backdropPath else { return nil }
        return URL(string: URLConfiguration.mediaPath + posterPath)
    }
    
}

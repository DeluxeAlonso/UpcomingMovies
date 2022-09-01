//
//  List.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct List: Decodable {

    let id: String
    let name: String
    let description: String?
    let backdropPath: String?
    let averageRating: Double?
    let runtime: Int?
    let movieCount: Int
    let movies: [Movie]?

    private enum CodingKeys: String, CodingKey {
        case id, name, description, runtime
        case backdropPath = "backdrop_path"
        case averageRating = "average_rating"
        case movieCount = "number_of_items"
        case movies = "items"
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {
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

extension List: DomainConvertible {

    func asDomain() -> UpcomingMoviesDomain.List {
        let movies = self.movies?.map { $0.asDomain() }
        return UpcomingMoviesDomain.List(id: id, name: name, description: description,
                                         backdropPath: backdropPath, averageRating: averageRating,
                                         runtime: runtime, movieCount: movieCount, movies: movies)
    }

}

//
//  List+MockInitializer.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 8/09/22.
//

extension List {

    static func create(id: String = "1",
                       name: String = "Test",
                       description: String = "Test",
                       backdropPath: String? = nil,
                       averageRating: Double? = nil,
                       runtime: String? = nil,
                       movieCount: Int = 1,
                       movies: [Movie]? = [Movie.create()],
                       revenue: Double? = nil) -> List {
        List(id: id,
             name: name,
             description: description,
             backdropPath: backdropPath,
             averageRating: averageRating,
             runtime: runtime,
             movieCount: movieCount,
             movies: movies,
             revenue: revenue)
    }

}

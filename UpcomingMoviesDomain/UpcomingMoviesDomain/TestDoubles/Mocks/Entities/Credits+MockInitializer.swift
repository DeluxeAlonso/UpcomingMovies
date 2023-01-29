//
//  Credits+MockInitializer.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/5/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

public extension MovieCredits {

    static func with(cast: [Cast] = [Cast.with()], crew: [Crew] = [Crew.with()]) -> MovieCredits {
        MovieCredits(cast: cast, crew: crew)
    }

    static func withEmptyValues() -> MovieCredits {
        MovieCredits(cast: [], crew: [])
    }

}

public extension Cast {

    static func with(id: Int = 1,
                     character: String = "Batman",
                     name: String = "Christian Bale",
                     photoPath: String? = nil) -> Cast {
        Cast(id: id, character: character, name: name, photoPath: photoPath)
    }

}

public extension Crew {

    static func with(id: Int = 1,
                     job: String = "Test Job",
                     name: String = "Test Name",
                     photoPath: String? = nil) -> Crew {
        Crew(id: id, job: job, name: name, photoPath: photoPath)
    }

}

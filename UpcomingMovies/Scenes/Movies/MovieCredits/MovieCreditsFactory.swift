//
//  MovieCreditsFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

final class MovieCreditsFactory: MovieCreditsFactoryProtocol {

    var sections = [MovieCreditsCollapsibleSection(type: .cast, opened: true),
                    MovieCreditsCollapsibleSection(type: .crew, opened: false)]

}

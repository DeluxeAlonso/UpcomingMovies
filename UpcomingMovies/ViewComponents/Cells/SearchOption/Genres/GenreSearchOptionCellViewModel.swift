//
//  GenreSearchOptionCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol GenreSearchOptionCellViewModelProtocol {

    var id: Int { get }
    var name: String? { get }

}

final class GenreSearchOptionCellViewModel: GenreSearchOptionCellViewModelProtocol {

    var id: Int
    var name: String?

    init(genre: Genre) {
        id = genre.id
        name = genre.name
    }

}

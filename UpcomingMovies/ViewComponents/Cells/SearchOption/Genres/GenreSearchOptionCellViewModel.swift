//
//  GenreSearchOptionCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain

final class GenreSearchOptionCellViewModel {
    
    var id: Int
    var name: String?
    
    init(genre: Genre) {
        id = genre.id
        name = genre.name
    }
    
}

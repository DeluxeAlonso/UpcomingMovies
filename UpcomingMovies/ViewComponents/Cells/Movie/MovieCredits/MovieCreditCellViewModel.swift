//
//  MovieCreditCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieCreditCellViewModel {
    
    let name: String
    let role: String
    let profileURL: URL?
    
    init(cast: Cast) {
        name = cast.name
        role = cast.character
        profileURL = cast.profileURL
    }
    
    init(crew: Crew) {
        name = crew.name
        role = crew.job
        profileURL = crew.profileURL
    }
    
}

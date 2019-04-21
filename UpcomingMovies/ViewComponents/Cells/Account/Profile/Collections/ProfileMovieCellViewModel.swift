//
//  ProfileMovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class ProfileMovieCellViewModel {
    
    let title: String
    let backdropURL: URL?
    
    init(_ favorite: Movie) {
        title = favorite.title
        backdropURL = favorite.backdropURL
    }
    
}

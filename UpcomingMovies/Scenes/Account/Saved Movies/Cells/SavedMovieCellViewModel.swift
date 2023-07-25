//
//  SavedMovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol SavedMovieCellViewModelProtocol {

    var title: String { get }
    var backdropURL: URL? { get }

}

final class SavedMovieCellViewModel: SavedMovieCellViewModelProtocol {

    let title: String
    let backdropURL: URL?

    init(_ favorite: Movie) {
        title = favorite.title
        backdropURL = favorite.backdropURL
    }

}

//
//  CustomListCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol CustomListCellViewModelProtocol {

    var name: String { get }
    var description: String? { get }
    var movieCount: Int { get }

}

final class CustomListCellViewModel: CustomListCellViewModelProtocol {

    let name: String
    let description: String?
    let movieCount: Int

    init(_ list: List) {
        self.name = list.name
        self.description = list.description
        self.movieCount = list.movieCount
    }

}

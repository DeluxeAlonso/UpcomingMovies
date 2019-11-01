//
//  CustomListCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain

final class CustomListCellViewModel {
    
    let name: String
    let description: String?
    let movieCount: Int
    
    init(_ list: List) {
        self.name = list.name
        self.description = list.description
        self.movieCount = list.movieCount
    }
    
}

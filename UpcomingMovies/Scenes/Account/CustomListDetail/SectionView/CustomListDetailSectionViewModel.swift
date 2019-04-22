//
//  CustomListDetailSectionViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class CustomListDetailSectionViewModel {
    
    let movieCountText: String
    
    init(movieCount: Int) {
        movieCountText = "\(movieCount) movies"
    }
    
}

//
//  MovieVideoCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieVideoCellViewModel {
    
    let name: String
    let key: String
    let thumbnailURL: URL?
    
    init(_ video: Video) {
        name = video.name
        key = video.key
        thumbnailURL = video.thumbnailURL
    }
    
}

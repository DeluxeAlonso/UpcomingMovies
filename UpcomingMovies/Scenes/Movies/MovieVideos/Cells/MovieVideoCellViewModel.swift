//
//  MovieVideoCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol MovieVideoCellViewModelProtocol {

    var name: String { get }
    var thumbnailURL: URL? { get }

}

final class MovieVideoCellViewModel: MovieVideoCellViewModelProtocol {

    let name: String
    let thumbnailURL: URL?

    init(_ video: VideoProtocol) {
        name = video.name
        thumbnailURL = video.thumbnailURL
    }

}

//
//  VideoProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 18/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol VideoProtocol {

    var id: String { get }
    var key: String { get }
    var name: String { get }
    var site: String { get }
    var browserURL: URL? { get }
    var deepLinkURL: URL? { get }
    var thumbnailURL: URL? { get }

}

extension Video: VideoProtocol {}

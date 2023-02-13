//
//  UpcomingMoviesDisplayMode.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

enum UpcomingMoviesPresentationMode: Int {
    case preview
    case detail

    var cellIdentifier: String {
        switch self {
        case .preview:
            return UpcomingMoviePreviewCollectionViewCell.dequeueIdentifier
        case .detail:
            return UpcomingMovieExpandedCollectionViewCell.dequeueIdentifier
        }
    }
}

//
//  MovieDetailPosterViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

protocol MovieDetailPosterViewModelProtocol {

    var backdropURL: URL? { get }
    var posterURL: URL? { get }

}

struct MovieDetailPosterViewModel: MovieDetailPosterViewModelProtocol {

    let backdropURL: URL?
    let posterURL: URL?

    init(_ renderContent: MovieDetailPosterRenderContent?) {
        self.backdropURL = renderContent?.backdropURL
        self.posterURL = renderContent?.posterURL
    }

}

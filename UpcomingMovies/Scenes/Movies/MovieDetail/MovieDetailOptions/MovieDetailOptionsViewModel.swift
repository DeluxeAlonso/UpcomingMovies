//
//  MovieDetailOptionsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

protocol MovieDetailOptionsViewModelProtocol {

    var options: [MovieDetailOption] { get }

}

struct MovieDetailOptionsViewModel: MovieDetailOptionsViewModelProtocol {

    let options: [MovieDetailOption]

    init(_ renderContent: MovieDetailOptionsRenderContent?) {
        self.options = renderContent?.options ?? []
    }

}

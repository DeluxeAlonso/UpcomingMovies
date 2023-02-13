//
//  UpcomingMoviesViewFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/5/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol UpcomingMoviesFactoryProtocol {

    func makeGridBarButtonItemContents(for presentationMode: UpcomingMoviesPresentationMode) -> [ToggleBarButtonItemContent]

}

final class UpcomingMoviesFactory: UpcomingMoviesFactoryProtocol {

    // MARK: - UpcomingMoviesFactoryProtocol

    func makeGridBarButtonItemContents(for presentationMode: UpcomingMoviesPresentationMode) -> [ToggleBarButtonItemContent] {
        let preview = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "List")),
                                                 accessibilityLabel: LocalizedStrings.expandMovieCellsHint())
        let detail = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "Grid")),
                                                accessibilityLabel: LocalizedStrings.collapseMovieCellsHint())

        switch presentationMode {
        case .preview:
            return [preview, detail]
        case .detail:
            return [detail, preview]
        }
    }

}

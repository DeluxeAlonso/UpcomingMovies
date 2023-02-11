//
//  UpcomingMoviesViewFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/5/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol UpcomingMoviesFactoryProtocol {

}

final class UpcomingMoviesFactory: UpcomingMoviesFactoryProtocol {

    func makeGridBarButtonItemContents() -> [ToggleBarButtonItemContent] {
        let preview = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "List")),
                                                 accessibilityLabel: LocalizedStrings.expandMovieCellsHint())
        let detail = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "Grid")),
                                                accessibilityLabel: LocalizedStrings.collapseMovieCellsHint())

        return [preview, detail]
    }

}

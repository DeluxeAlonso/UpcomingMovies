//
//  UpcomingMoviesViewFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/5/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol UpcomingMoviesFactoryProtocol {

    func makeGridBarButtonItemContents() -> [ToggleBarButtonItemContent]

}

final class UpcomingMoviesFactory: UpcomingMoviesFactoryProtocol {

    // TODO: - Remove this dependency and replace it with a parameter in its methods.
    private let userPreferencesHandler: UserPreferencesHandlerProtocol

    // MARK: - Initializers

    init(userPreferencesHandler: UserPreferencesHandlerProtocol) {
        self.userPreferencesHandler = userPreferencesHandler
    }

    // MARK: - UpcomingMoviesFactoryProtocol

    func makeGridBarButtonItemContents() -> [ToggleBarButtonItemContent] {
        let preview = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "List")),
                                                 accessibilityLabel: LocalizedStrings.expandMovieCellsHint())
        let detail = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "Grid")),
                                                accessibilityLabel: LocalizedStrings.collapseMovieCellsHint())

        return [preview, detail]
    }

}

//
//  FavoriteToggleBarButtonItem.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

final class FavoriteToggleBarButtonItem: ToggleBarButtonItem {

    init() {
        let favoriteOff = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "FavoriteOff")),
                                                     accessibilityLabel: LocalizedStrings.addToFavoritesHint())
        let favoriteOn = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "FavoriteOn")),
                                                    accessibilityLabel: LocalizedStrings.removeFromFavoritesHint())
        super.init(contents: [favoriteOff, favoriteOn])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

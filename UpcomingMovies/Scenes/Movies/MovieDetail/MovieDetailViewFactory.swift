//
//  MovieDetailViewFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieDetailViewFactory {
    
    class func makeFavoriteBarButtonItem() -> ToggleBarButtonItem {
        let favoriteOff = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "FavoriteOff")),
                                                     accessibilityLabel: LocalizedStrings.addToFavoritesHint.localized)
        let favoriteOn = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "FavoriteOn")),
                                                    accessibilityLabel: LocalizedStrings.removeFromFavoritesHint.localized)
        
        return ToggleBarButtonItem(contents: [favoriteOff, favoriteOn])
    }
    
}

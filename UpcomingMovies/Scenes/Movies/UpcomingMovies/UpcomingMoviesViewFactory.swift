//
//  UpcomingMoviesViewFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/5/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class UpcomingMoviesViewFactory {
    
    class func makeGridBarButtonItem() -> ToggleBarButtonItem {
        let preview = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "List")),
                                                 accessibilityLabel: LocalizedStrings.expandMovieCellsHint.localized)
        let detail = ToggleBarButtonItemContent(display: .right(#imageLiteral(resourceName: "Grid")),
                                                accessibilityLabel: LocalizedStrings.collapseMovieCellsHint.localized)
        
        return ToggleBarButtonItem(contents: [preview, detail])
    }
    
}

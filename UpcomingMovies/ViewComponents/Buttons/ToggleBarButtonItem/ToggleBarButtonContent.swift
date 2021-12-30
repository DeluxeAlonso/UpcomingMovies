//
//  ToggleBarButtonItemState.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/4/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

struct ToggleBarButtonItemContent: ToggleBarButtonItemContentProtocol {

    let display: ToggleBarButtonItemDisplay
    let accessibilityLabel: String?
    let accessibilityHint: String?

    init(display: ToggleBarButtonItemDisplay,
         accessibilityLabel: String? = nil,
         accessibilityHint: String? = nil) {
        self.display = display
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
    }

}

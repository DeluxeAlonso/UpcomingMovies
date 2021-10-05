//
//  ToggleBarButtonItemContentProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 14/08/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

protocol ToggleBarButtonItemContentProtocol {

    var display: ToggleBarButtonItemDisplay { get }
    var accessibilityLabel: String? { get }
    var accessibilityHint: String? { get }

}

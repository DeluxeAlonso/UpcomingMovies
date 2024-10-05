//
//  ToggleBarButtonItemViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

protocol ToggleBarButtonItemViewModelProtocol {

    /// We support more than two items for the ToggleBarButtonItem. First item will be displayed initially.
    var contents: [ToggleBarButtonItemContentProtocol] { get }

}

struct ToggleBarButtonItemViewModel: ToggleBarButtonItemViewModelProtocol {

    let contents: [ToggleBarButtonItemContentProtocol]

}

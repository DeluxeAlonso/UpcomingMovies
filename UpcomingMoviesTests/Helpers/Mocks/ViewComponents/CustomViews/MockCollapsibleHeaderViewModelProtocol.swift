//
//  MockCollapsibleHeaderViewModelProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 10/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

@testable import UpcomingMovies

final class MockCollapsibleHeaderViewModelProtocol: CollapsibleHeaderViewModelProtocol {

    var opened: Bool = false
    var section: Int = 0
    var title: String = ""
    var shouldAnimate: Bool = false

}

//
//  MockCollapsibleHeaderViewDelegate.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 10/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

@testable import UpcomingMovies

final class MockCollapsibleHeaderViewDelegate: CollapsibleHeaderViewDelegate {

    private(set) var sectionToggledCallCount = 0
    func collapsibleHeaderView(sectionHeaderView: CollapsibleCollectionHeaderView, sectionToggled section: Int) {
        sectionToggledCallCount += 1
    }

}

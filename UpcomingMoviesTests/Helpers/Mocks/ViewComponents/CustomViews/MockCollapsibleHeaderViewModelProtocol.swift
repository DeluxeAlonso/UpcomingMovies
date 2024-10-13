//
//  MockCollapsibleHeaderViewModelProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 10/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockCollapsibleHeaderViewModelProtocol: CollapsibleHeaderViewModelProtocol {

    var opened: Bool = false
    var section: Int = 0
    var title: String = ""
    var shouldAnimate: Bool = false

    var arrowRotationValueResult = 0.0
    private(set) var arrowRotationValueCallCount = 0
    func arrowRotationValue() -> CGFloat {
        arrowRotationValueCallCount += 1
        return arrowRotationValueResult
    }

}

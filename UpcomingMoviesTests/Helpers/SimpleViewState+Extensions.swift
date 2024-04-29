//
//  SimpleViewState+Extensions.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 28/04/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

extension SimpleViewState: Equatable {

    public static func == (lhs: SimpleViewState, rhs: SimpleViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (let .paging(lhsEntities, _), let .paging(rhsEntities, _)):
            return lhsEntities == rhsEntities
        case (let .populated(lhsEntities), let .populated(rhsEntities)):
            return lhsEntities == rhsEntities
        case (.empty, .empty):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }

}

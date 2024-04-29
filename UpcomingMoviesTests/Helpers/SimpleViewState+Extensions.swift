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
        case (let .paging(_, lhsNext), let .paging(_, rhsNext)):
            return lhsNext == rhsNext
        case (.populated, .populated):
            return true
        case (.empty, .empty):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }

}

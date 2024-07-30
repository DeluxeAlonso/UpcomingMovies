//
//  SimpleViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

enum SimpleViewState<Entity> {

    case initial
    case paging([Entity], next: Int)
    case populated([Entity])
    case empty
    case error(Error)

    var currentEntities: [Entity] {
        switch self {
        case .populated(let entities):
            return entities
        case .paging(let entities, _):
            return entities
        case .initial, .empty, .error:
            return []
        }
    }

    var currentPage: Int {
        switch self {
        case .initial, .populated, .empty, .error:
            return 1
        case .paging(_, let page):
            return page
        }
    }

    var isInitialPage: Bool {
        currentPage == 1
    }

    var needsPrefetch: Bool {
        switch self {
        case .initial, .populated, .empty, .error:
            return false
        case .paging:
            return true
        }
    }

}

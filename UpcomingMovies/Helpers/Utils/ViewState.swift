//
//  ViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum SimpleViewState<Entity>: Equatable {
    
    case loading
    case paging([Entity], next: Int)
    case populated([Entity])
    case empty
    case error(Error)
    
    static func == (lhs: SimpleViewState, rhs: SimpleViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (let .paging(lhsEntities, _), let .paging(rhsEntities, _)):
            return lhsEntities.count == rhsEntities.count
        case (let .populated(lhsEntities), let .populated(rhsEntities)):
            return lhsEntities.count == rhsEntities.count
        case (.empty, .empty):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
    
    var currentEntities: [Entity] {
        switch self {
        case .populated(let entities):
            return entities
        case .paging(let entities, _):
            return entities
        case .loading, .empty, .error:
            return []
        }
    }
    
    var currentPage: Int {
        switch self {
        case .populated, .empty, .error, .loading:
            return 1
        case .paging(_, let page):
            return page
        }
    }
    
}

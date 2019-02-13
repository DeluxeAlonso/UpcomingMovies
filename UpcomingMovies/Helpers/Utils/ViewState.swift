//
//  ViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum SimpleViewState<Entity> {
    
    case loading
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

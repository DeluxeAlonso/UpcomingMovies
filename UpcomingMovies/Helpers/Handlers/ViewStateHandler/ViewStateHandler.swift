//
//  ViewStateHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 27/03/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import Foundation

protocol ViewStateHandlerProtocol {

    func processResult<T: Equatable>(_ entities: [T],
                                     currentPage: Int,
                                     currentEntities: [T]) -> SimpleViewState<T>

}

struct ViewStateHandler: ViewStateHandlerProtocol {

    func processResult<T: Equatable>(_ entities: [T],
                                     currentPage: Int,
                                     currentEntities: [T]) -> SimpleViewState<T> {
        var allEntities = currentPage == 1 ? [] : currentEntities
        allEntities.append(contentsOf: entities)
        guard !allEntities.isEmpty else { return .empty }

        return entities.isEmpty ? .populated(allEntities) : .paging(allEntities, next: currentPage + 1)
    }
    
}

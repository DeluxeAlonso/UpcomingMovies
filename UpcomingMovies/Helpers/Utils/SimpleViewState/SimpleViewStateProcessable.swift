//
//  SimpleViewStateProcessable.swift
//  UpcomingMovies
//
//  Created by Alonso on 24/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

protocol SimpleViewStateProcessable {

    func processResult<T>(_ entities: [T]) -> SimpleViewState<T>

    func processResult<T>(_ entities: [T],
                          currentPage: Int,
                          currentEntities: [T]) -> SimpleViewState<T>

}

extension SimpleViewStateProcessable {

    func processResult<T>(_ entities: [T]) -> SimpleViewState<T> {
        entities.isEmpty ? .empty : .populated(entities)
    }

    func processResult<T>(_ entities: [T],
                          currentPage: Int,
                          currentEntities: [T]) -> SimpleViewState<T> {
        var allEntities = currentPage == 1 ? [] : currentEntities
        allEntities.append(contentsOf: entities)
        guard !allEntities.isEmpty else { return .empty }

        return entities.isEmpty ? .populated(allEntities) : .paging(allEntities, next: currentPage + 1)
    }

}

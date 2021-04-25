//
//  SimpleViewStateHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 27/03/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

//struct SimpleViewStateHandler: SimpleViewStateHandlerProtocol {
//
//    func processResult<T: Equatable>(_ entities: [T]) -> SimpleViewState<T> {
//        return entities.isEmpty ? .empty : .populated(entities)
//    }
//
//    func processResult<T: Equatable>(_ entities: [T],
//                                     currentPage: Int,
//                                     currentEntities: [T]) -> SimpleViewState<T> {
//        var allEntities = currentPage == 1 ? [] : currentEntities
//        allEntities.append(contentsOf: entities)
//        guard !allEntities.isEmpty else { return .empty }
//
//        return entities.isEmpty ? .populated(allEntities) : .paging(allEntities, next: currentPage + 1)
//    }
//    
//}

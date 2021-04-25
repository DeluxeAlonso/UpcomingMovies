//
//  MockViewStateHandler.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 27/03/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

// We use the ViewStateHandler implementation of the project.
struct MockViewStateHandler: SimpleViewStateHandlerProtocol {

    func processResult<T>(_ entities: [T]) -> SimpleViewState<T> where T: Equatable {
        return SimpleViewStateHandler().processResult(entities)
    }

    func processResult<T>(_ entities: [T], currentPage: Int, currentEntities: [T]) -> SimpleViewState<T> where T: Equatable {
        return SimpleViewStateHandler().processResult(entities, currentPage: currentPage, currentEntities: currentEntities)
    }

}

//
//  ViewStateHandlerProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 24/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

protocol ViewStateHandlerProtocol {

    func processResult<T: Equatable>(_ entities: [T]) -> SimpleViewState<T>

    func processResult<T: Equatable>(_ entities: [T],
                                     currentPage: Int,
                                     currentEntities: [T]) -> SimpleViewState<T>

}

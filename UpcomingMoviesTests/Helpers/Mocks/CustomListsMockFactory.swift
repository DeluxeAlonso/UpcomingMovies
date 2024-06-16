//
//  CustomListsMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies

final class MockCustomListsInteractor: CustomListsInteractorProtocol {

    var getCustomListsResult: Result<[ListProtocol], Error>?
    func getCustomLists(page: Int?, completion: @escaping (Result<[ListProtocol], Error>) -> Void) {
        if let getCustomListsResult {
            completion(getCustomListsResult)
        }
    }

}

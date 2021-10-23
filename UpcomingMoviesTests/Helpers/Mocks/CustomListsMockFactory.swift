//
//  CustomListsMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class MockCustomListsInteractor: CustomListsInteractorProtocol {

    var getCustomListsResult: Result<[List], Error>!
    func getCustomLists(page: Int?, completion: @escaping (Result<[List], Error>) -> Void) {
        completion(getCustomListsResult!)
    }

}

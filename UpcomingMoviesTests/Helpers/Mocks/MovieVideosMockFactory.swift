//
//  MovieVideosMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 8/2/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MockMovieVideosInteractor: MovieVideosInteractorProtocol {
    
    var getMovieVideosResult: Result<[Video], Error>?
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[Video], Error>) -> Void) {
        completion(getMovieVideosResult!)
    }
    
}

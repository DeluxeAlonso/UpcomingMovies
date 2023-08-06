//
//  MovieVideosMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 8/2/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MockMovieVideosInteractor: MovieVideosInteractorProtocol {

    var getMovieVideosResult: Result<[Video], Error>?
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[Video], Error>) -> Void) {
        if let getMovieVideosResult {
            completion(getMovieVideosResult)
        }
    }

}

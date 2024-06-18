//
//  MovieVideosInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/2/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct MovieVideosInteractor: MovieVideosInteractorProtocol {

    private let movieUseCase: MovieUseCaseProtocol

    init(movieUseCase: MovieUseCaseProtocol) {
        self.movieUseCase = movieUseCase
    }

    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[VideoProtocol], Error>) -> Void) {
        movieUseCase.getMovieVideos(for: movieId, page: page, completion: { result in
            switch result {
            case .success(let videos):
                completion(.success(videos.map(VideoModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

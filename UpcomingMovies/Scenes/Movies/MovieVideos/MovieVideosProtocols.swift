//
//  MovieVideosProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

protocol MovieVideosViewModelProtocol {

    var movieTitle: String { get }
    var emptyVideoResultsTitle: String { get }

    var viewState: AnyBehaviorBindable<MovieVideosViewState> { get }
    var startLoading: AnyBehaviorBindable<Bool> { get }

    var videoCells: [MovieVideoCellViewModelProtocol] { get }

    func videoURL(at index: Int) -> URL?
    func getMovieVideos(showLoader: Bool)

}

protocol MovieVideosInteractorProtocol {

    func getMovieVideos(for movieId: Int, page: Int?,
                        completion: @escaping (Result<[VideoProtocol], Error>) -> Void)

}

protocol MovieVideosCoordinatorProtocol: AnyObject {}

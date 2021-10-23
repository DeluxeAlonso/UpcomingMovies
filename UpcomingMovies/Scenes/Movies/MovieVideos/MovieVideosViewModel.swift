//
//  MovieVideosViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MovieVideosViewModel: MovieVideosViewModelProtocol, SimpleViewStateProcessable {

    // MARK: - Dependencies

    private let movieId: Int
    private let interactor: MovieVideosInteractorProtocol

    // MARK: - Reactive properties

    private(set) var viewState: Bindable<SimpleViewState<Video>> = Bindable(.initial)
    private(set) var startLoading: Bindable<Bool> = Bindable(false)

    // MARK: - Computed properties

    var videoCells: [MovieVideoCellViewModelProtocol] {
        return videos.map { MovieVideoCellViewModel($0) }
    }

    private var videos: [Video] {
        return viewState.value.currentEntities
    }

    // MARK: - Stored properties

    let movieTitle: String

    // MARK: - Initializers

    init(movieId: Int, movieTitle: String,
         interactor: MovieVideosInteractorProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle

        self.interactor = interactor
    }

    // MARK: - MovieVideosViewModelProtocol

    func videoURL(at index: Int) -> URL? {
        let video = videos[index]
        if let url = video.deepLinkURL {
            return url
        } else {
            return video.browserURL
        }
    }

    func getMovieVideos(showLoader: Bool = false) {
        startLoading.value = showLoader
        interactor.getMovieVideos(for: movieId, page: nil, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let videos):
                self.viewState.value =  self.processResult(videos)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }

}

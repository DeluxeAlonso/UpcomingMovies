//
//  MovieVideosViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieVideosViewModel {
    
    let movieId: Int
    let movieTitle: String
    
    var movieClient = MovieClient()
    let viewState: Bindable<SimpleViewState<Video>> = Bindable(.initial)
    
    var startLoading: Bindable<Bool> = Bindable(false)
    
    var videoCells: [MovieVideoCellViewModel] {
        return videos.map { MovieVideoCellViewModel($0) }
    }
    
    private var videos: [Video] {
        return viewState.value.currentEntities
    }
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String) {
        self.movieId = movieId
        self.movieTitle = movieTitle
    }
    
    // MARK: - Public

    func playVideo(at index: Int) {
        let application = UIApplication.shared
        let videoToPlay = videos[index]
        guard let deepLinkURL = videoToPlay.deepLinkURL,
            application.canOpenURL(deepLinkURL) else {
                guard let browserURL = videoToPlay.browserURL else { return }
                application.open(browserURL, options: [:], completionHandler: nil)
                return
        }
        application.open(deepLinkURL, options: [:], completionHandler: nil)
    }
    
    // MARK: - Networking
    
    func getMovieVideos() {
        startLoading.value = true
        movieClient.getMovieVideos(with: movieId) { result in
            switch result {
            case .success(let videoResult):
                guard let videoResult = videoResult else { return }
                self.processVideoResult(videoResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    private func processVideoResult(_ videoResult: VideoResult) {
        startLoading.value = false
        let fetchedVideos = videoResult.results
        if fetchedVideos.isEmpty {
            viewState.value = .empty
        } else {
            viewState.value = .populated(fetchedVideos)
        }
    }

}

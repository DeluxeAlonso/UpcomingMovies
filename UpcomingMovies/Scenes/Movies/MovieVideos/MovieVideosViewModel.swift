//
//  MovieVideosViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MovieVideosViewModel {
    
    let movieId: Int
    let movieTitle: String
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let movieUseCase: MovieUseCaseProtocol
    
    let viewState: Bindable<SimpleViewState<Video>> = Bindable(.initial)
    
    var startLoading: Bindable<Bool> = Bindable(false)
    
    var videoCells: [MovieVideoCellViewModel] {
        return videos.map { MovieVideoCellViewModel($0) }
    }
    
    private var videos: [Video] {
        return viewState.value.currentEntities
    }
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String, useCaseProvider: UseCaseProviderProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        
        self.useCaseProvider = useCaseProvider
        self.movieUseCase = self.useCaseProvider.movieUseCase()
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
    
    func getMovieVideos(showLoader: Bool = false) {
        startLoading.value = showLoader
        movieUseCase.getMovieVideos(for: movieId, page: nil, completion: { result in
            switch result {
            case .success(let videos):
                self.processVideosResult(videos)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processVideosResult(_ videos: [Video]) {
        startLoading.value = false
        if videos.isEmpty {
            viewState.value = .empty
        } else {
            viewState.value = .populated(videos)
        }
    }

}

//
//  MovieVideosViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MovieVideosViewModel: MovieVideosViewModelProtocol {
    
    private let interactor: MovieVideosInteractorProtocol
    
    var movieId: Int
    var movieTitle: String
    
    let viewState: Bindable<SimpleViewState<Video>> = Bindable(.initial)
    
    var startLoading: Bindable<Bool> = Bindable(false)
    
    var videoCells: [MovieVideoCellViewModel] {
        return videos.map { MovieVideoCellViewModel($0) }
    }
    
    private var videos: [Video] {
        return viewState.value.currentEntities
    }
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String, interactor: MovieVideosInteractorProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        
        self.interactor = interactor
    }
    
    // MARK: - Public
    
    func videoURL(at index: Int) -> URL? {
        let video = videos[index]
        if let url = video.deepLinkURL {
            return url
        } else {
            return video.browserURL
        }
    }
    
    // MARK: - Networking
    
    func getMovieVideos(showLoader: Bool = false) {
        startLoading.value = showLoader
        interactor.getMovieVideos(for: movieId, page: nil, completion: { result in
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

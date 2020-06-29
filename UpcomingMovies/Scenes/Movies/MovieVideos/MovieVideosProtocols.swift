//
//  MovieVideosProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol MovieVideosViewModelProtocol {
    
    var movieId: Int { get set }
    var movieTitle: String { get set }
    
    var viewState: Bindable<SimpleViewState<Video>> { get }
    var startLoading: Bindable<Bool> { get }
    
    var videoCells: [MovieVideoCellViewModel] { get }
    
    func playVideo(at index: Int)
    func getMovieVideos(showLoader: Bool)
    
}

protocol MovieVideosCoordinatorProtocol: class {}

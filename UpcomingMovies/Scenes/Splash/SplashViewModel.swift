//
//  SplashViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SplashViewModel {
    
    private let genreUseCase: GenreUseCaseProtocol
    private let configurationUseCase: ConfigurationUseCaseProtocol
    
    private var dispatchGroup: DispatchGroup!
    
    var initialDownloadsEnded: (() -> Void)?
    
    init() {
        let useCaseProvider = InjectionFactory.useCaseProvider()
        self.genreUseCase = useCaseProvider.genreUseCase()
        self.configurationUseCase = useCaseProvider.configurationUseCase()
    }
    
    func startInitialDownloads() {
        self.dispatchGroup = DispatchGroup()
        DispatchQueue.global(qos: .userInitiated).async {
            self.getAppConfiguration()
            self.getMovieGenres()
            
            self.dispatchGroup.wait()
            DispatchQueue.main.async {
                self.initialDownloadsEnded?()
            }
        }
    }

    /**
    * Fetch API configurations.
    */
    private func getAppConfiguration() {
        dispatchGroup.enter()
        configurationUseCase.getConfiguration { [weak self] result in
            _ = result.map { ConfigurationHandler.shared.setConfiguration($0) }
            self?.dispatchGroup.leave()
        }
    }
    
    /**
     * Fetch all the movie genres and save them locally.
     */
    private func getMovieGenres() {
        dispatchGroup.enter()
        genreUseCase.fetchAll { [weak self] result in
            _ = result.map { GenreHandler.shared.setGenres($0) }
            self?.dispatchGroup.leave()
        }
    }
    
}

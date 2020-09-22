//
//  SplashViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SplashViewModel: SplashViewModelProtocol {
    
    private let interactor: SplashInteractorProtocol
    private let genreHandler: GenreHandlerProtocol
    private let configurationHandler: ConfigurationHandlerProtocol
    
    private var dispatchGroup: DispatchGroup!
    
    var initialDownloadsEnded: (() -> Void)?
    
    init(interactor: SplashInteractorProtocol,
         genreHandler: GenreHandlerProtocol,
         configurationHandler: ConfigurationHandlerProtocol) {
        self.interactor = interactor
        self.genreHandler = genreHandler
        self.configurationHandler = configurationHandler
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
        interactor.getAppConfiguration { [weak self] result in
            _ = result.map { self?.configurationHandler.setConfiguration($0) }
            self?.dispatchGroup.leave()
        }
    }
    
    /**
     * Fetch all the movie genres and save them locally.
     */
    private func getMovieGenres() {
        dispatchGroup.enter()
        interactor.getAllGenres { [weak self] result in
            _ = result.map { self?.genreHandler.setGenres($0) }
            self?.dispatchGroup.leave()
        }
    }
    
}

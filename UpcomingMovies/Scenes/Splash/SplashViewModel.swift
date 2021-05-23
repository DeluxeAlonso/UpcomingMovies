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

    // MARK: - Dependencies
    
    private let interactor: SplashInteractorProtocol
    private let genreHandler: GenreHandlerProtocol
    private let configurationHandler: ConfigurationHandlerProtocol

    // MARK: - Properties
    
    var initialDownloadsEnded: (() -> Void)?

    // MARK: - Initializers
    
    init(interactor: SplashInteractorProtocol,
         genreHandler: GenreHandlerProtocol,
         configurationHandler: ConfigurationHandlerProtocol) {
        self.interactor = interactor
        self.genreHandler = genreHandler
        self.configurationHandler = configurationHandler
    }

    // MARK: - SplashViewModelProtocol
    
    func startInitialDownloads() {
        let dispatchGroup = DispatchGroup()
        DispatchQueue.global(qos: .userInitiated).async {
            dispatchGroup.enter()
            self.getAppConfiguration { dispatchGroup.leave() }

            dispatchGroup.enter()
            self.getMovieGenres { dispatchGroup.leave() }

            dispatchGroup.notify(queue: .main) {
                self.initialDownloadsEnded?()
            }
        }
    }

    // MARK: - Private

    /**
    * Fetch API configurations.
    */
    private func getAppConfiguration(completion: @escaping () -> Void) {
        interactor.getAppConfiguration { [weak self] result in
            _ = result.map { self?.configurationHandler.setConfiguration($0) }
            completion()
        }
    }
    
    /**
     * Fetch all the movie genres and save them locally.
     */
    private func getMovieGenres(completion: @escaping () -> Void) {
        interactor.getAllGenres { [weak self] result in
            _ = result.map { self?.genreHandler.setGenres($0) }
            completion()
        }
    }
    
}

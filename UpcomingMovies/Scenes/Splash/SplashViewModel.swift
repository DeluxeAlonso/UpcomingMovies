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

    var initialDownloadsEnded: Bindable<Void> = Bindable(())

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

        dispatchGroup.enter()
        interactor.getAppConfiguration { result in
            self.updateAppConfiguration(result.getWrappedValue())
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        interactor.getAllGenres { result in
            self.updateAvailableMovieGenres(result.getWrappedValue())
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
            self.initialDownloadsEnded.fire()
        }
    }

    // MARK: - Private

    private func updateAppConfiguration(_ configuration: Configuration?) {
        guard let configuration = configuration else { return }
        configurationHandler.setConfiguration(configuration)
    }

    private func updateAvailableMovieGenres(_ genres: [Genre]?) {
        guard let genres = genres else { return }
        genreHandler.setGenres(genres)
    }

}

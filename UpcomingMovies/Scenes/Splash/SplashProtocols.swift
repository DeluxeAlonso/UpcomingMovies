//
//  SplashProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/3/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol SplashViewModelProtocol {

    var initialDownloadsEnded: (() -> Void)? { get set }

    func startInitialDownloads()

}

protocol SplashInteractorProtocol {

    /**
    * Fetch API configurations.
    */
    func getAppConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void)

    /**
     * Fetch all the available movie genres
     */
    func getAllGenres(completion: @escaping (Result<[Genre], Error>) -> Void)

}

//
//  SplashViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class SplashViewModel {
    
    private let genreClient = GenreClient()
    
    var genresFetched: (() -> Void)?
    
    /**
     * Fetch all the movie genres and save them in the AppManager Singleton.
     */
    func getMovieGenres() {
        genreClient.getAllGenres { result in
            switch result {
            case .success(let genreResult):
                guard let genreResult = genreResult else { return }
                let genres = genreResult.genres
                AppManager.shared.genres = genres
                self.genresFetched?()
            case .failure(let error):
                self.genresFetched?()
                print(error.localizedDescription)
            }
        }
    }

}

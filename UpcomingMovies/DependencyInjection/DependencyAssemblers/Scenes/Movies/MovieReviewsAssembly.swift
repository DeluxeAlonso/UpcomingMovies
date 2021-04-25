//
//  MovieReviewsAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/17/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Swinject
import UpcomingMoviesDomain

final class MovieReviewsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MovieReviewsInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return MovieReviewsInteractor(useCaseProvider: useCaseProvider!)
        }
        
        container.register(MovieReviewsViewModelProtocol.self) { (resolver, movieId: Int?, movieTitle: String?) in
            let interactor = resolver.resolve(MovieReviewsInteractorProtocol.self)
            
            return MovieReviewsViewModel(movieId: movieId!,
                                         movieTitle: movieTitle!,
                                         interactor: interactor!)
        }
    }
    
}

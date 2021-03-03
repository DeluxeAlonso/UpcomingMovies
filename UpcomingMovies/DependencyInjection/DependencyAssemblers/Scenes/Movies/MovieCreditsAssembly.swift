//
//  MovieCreditsAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/17/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

final class MovieCreditsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MovieCreditsFactoryProtocol.self) { _ in
            MovieCreditsFactory()
        }
        
        container.register(MovieCreditsInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return MovieCreditsInteractor(useCaseProvider: useCaseProvider!)
        }
        
        container.register(MovieCreditsViewModelProtocol.self) { (resolver, movieId: Int?, movieTitle: String?) in
            let factory = resolver.resolve(MovieCreditsFactoryProtocol.self)
            let interactor = resolver.resolve(MovieCreditsInteractorProtocol.self)
            
            return MovieCreditsViewModel(movieId: movieId!, movieTitle: movieTitle!,
                                         interactor: interactor!, factory: factory!)
        }
    }
    
}

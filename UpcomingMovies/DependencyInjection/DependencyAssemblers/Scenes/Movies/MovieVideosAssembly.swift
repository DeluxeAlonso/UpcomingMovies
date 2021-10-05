//
//  MovieVideosAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/17/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Swinject
import UpcomingMoviesDomain

final class MovieVideosAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MovieVideosInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return MovieVideosInteractor(useCaseProvider: useCaseProvider!)
        }
        
        container.register(MovieVideosViewModelProtocol.self) { (resolver, movieId: Int?, movieTitle: String?) in
            let interactor = resolver.resolve(MovieVideosInteractorProtocol.self)
            
            return MovieVideosViewModel(movieId: movieId!,
                                        movieTitle: movieTitle!,
                                        interactor: interactor!)
        }
    }
    
}

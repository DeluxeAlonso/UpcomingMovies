//
//  UpcomingMoviesAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/15/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

class UpcomingMoviesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "Upcoming") { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return UpcomingMoviesInteractor(useCaseProvider: useCaseProvider!)
        }
        
        container.register(UpcomingMoviesViewModelProtocol.self) { resolver in
            let interactor = resolver.resolve(MoviesInteractorProtocol.self, name: "Upcoming")
            return UpcomingMoviesViewModel(interactor: interactor!)
        }
    }
    
}

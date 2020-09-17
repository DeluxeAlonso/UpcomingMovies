//
//  CustomListsAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/15/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

class CustomListsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CustomListsInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return CustomListsInteractor(useCaseProvider: useCaseProvider!)
        }
        
        container.register(CustomListsViewModelProtocol.self) { resolver in
            CustomListsViewModel(interactor: resolver.resolve(CustomListsInteractorProtocol.self)!)
        }
    }
    
}

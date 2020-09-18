//
//  AccountAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

class AccountAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AccountInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            let authHandler = resolver.resolve(AuthenticationHandlerProtocol.self)
            
            return AccountInteractor(useCaseProvider: useCaseProvider!,
                                     authHandler: authHandler!)
        }
        
        container.register(AccountViewModelProtocol.self) { resolver in
            AccountViewModel(interactor: resolver.resolve(AccountInteractorProtocol.self)!)
        }
    }
    
}

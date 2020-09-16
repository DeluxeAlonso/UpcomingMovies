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
        accountAssemble(container: container)
        authenticationAssemble(container: container)
        profileAssemble(container: container)
    }
    
    private func accountAssemble(container: Container) {
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
    
    private func authenticationAssemble(container: Container) {
        container.register(AuthPermissionViewModelProtocol.self) { (_, authPermissionURL: URL?) in
            AuthPermissionViewModel(authPermissionURL: authPermissionURL)
        }
    }
    
    private func profileAssemble(container: Container) {
        container.register(ProfileFactoryProtocol.self) { _ in
            ProfileFactory()
        }
        
        container.register(ProfileInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            
            return ProfileInteractor(useCaseProvider: useCaseProvider!)
        }
        
        container.register(ProfileViewModelProtocol.self) { (resolver, user: User?) in
            let interactor = resolver.resolve(ProfileInteractorProtocol.self)
            let factory = resolver.resolve(ProfileFactoryProtocol.self)
            
            return ProfileViewModel(userAccount: user,
                                    interactor: interactor!,
                                    factory: factory!)
        }
    }
    
}

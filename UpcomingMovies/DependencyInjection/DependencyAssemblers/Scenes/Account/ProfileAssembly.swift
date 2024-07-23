//
//  ProfileAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/15/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Swinject
import UpcomingMoviesDomain

final class ProfileAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ProfileFactoryProtocol.self) { _ in
            ProfileFactory()
        }

        container.register(ProfileInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return ProfileInteractor(userUseCase: useCaseProvider.userUseCase(),
                                     authUseCase: useCaseProvider.authUseCase(),
                                     accountUseCase: useCaseProvider.accountUseCase())
        }

        container.register(ProfileViewModelProtocol.self) { (resolver, user: UserProtocol) in
            guard let interactor = resolver.resolve(ProfileInteractorProtocol.self) else {
                fatalError("ProfileInteractorProtocol dependency could not be resolved")
            }
            guard let factory = resolver.resolve(ProfileFactoryProtocol.self) else {
                fatalError("ProfileFactoryProtocol dependency could not be resolved")
            }
            return ProfileViewModel(userAccount: user,
                                    interactor: interactor,
                                    factory: factory)
        }
    }

}

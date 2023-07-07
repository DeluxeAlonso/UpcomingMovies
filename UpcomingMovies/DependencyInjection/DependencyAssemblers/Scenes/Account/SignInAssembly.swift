//
//  SignInAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/07/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Swinject
import UpcomingMoviesDomain

final class SignInAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SignInInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return SignInInteractor(authUseCase: useCaseProvider.authUseCase(), userUseCase: useCaseProvider.userUseCase())
        }

        container.register(SignInViewModelProtocol.self) { resolver in
            guard let interactor = resolver.resolve(SignInInteractorProtocol.self) else {
                fatalError("SignInInteractorProtocol dependency could not be resolved")
            }
            return SignInViewModel(interactor: interactor)
        }
    }

}

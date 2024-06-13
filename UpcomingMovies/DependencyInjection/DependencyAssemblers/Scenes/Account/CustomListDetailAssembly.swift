//
//  CustomListDetailAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/15/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Swinject
import UpcomingMoviesDomain

final class CustomListDetailAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CustomListDetailInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return CustomListDetailInteractor(accountUseCase: useCaseProvider.accountUseCase())
        }

        container.register(CustomListDetailViewModelProtocol.self) { (resolver, list: ListProtocol) in
            guard let interactor = resolver.resolve(CustomListDetailInteractorProtocol.self) else {
                fatalError("CustomListDetailInteractorProtocol dependency could not be resolved")
            }
            return CustomListDetailViewModel(list, interactor: interactor)
        }
    }

}

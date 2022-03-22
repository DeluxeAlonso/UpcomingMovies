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

final class CustomListsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CustomListsInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return CustomListsInteractor(useCaseProvider: useCaseProvider)
        }

        container.register(CustomListsViewModelProtocol.self) { resolver in
            guard let interactor = resolver.resolve(CustomListsInteractorProtocol.self) else {
                fatalError("CustomListsInteractorProtocol dependency could not be resolved")
            }
            return CustomListsViewModel(interactor: interactor)
        }
    }

}

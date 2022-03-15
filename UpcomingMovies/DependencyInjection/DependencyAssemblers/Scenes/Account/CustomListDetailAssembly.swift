//
//  CustomListDetailAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/15/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

final class CustomListDetailAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CustomListDetailInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return CustomListDetailInteractor(useCaseProvider: useCaseProvider)
        }

        container.register(CustomListDetailViewModelProtocol.self) { (resolver, list: List) in
            guard let interactor = resolver.resolve(CustomListDetailInteractorProtocol.self) else {
                fatalError("CustomListDetailInteractorProtocol dependency could not be resolved")
            }
            return CustomListDetailViewModel(list, interactor: interactor)
        }
    }

}

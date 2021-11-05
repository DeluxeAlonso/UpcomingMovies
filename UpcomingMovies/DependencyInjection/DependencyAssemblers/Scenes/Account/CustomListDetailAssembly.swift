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
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return CustomListDetailInteractor(useCaseProvider: useCaseProvider!)
        }

        container.register(CustomListDetailViewModelProtocol.self) { (resolver, list: List?) in
            let interactor = resolver.resolve(CustomListDetailInteractorProtocol.self)
            return CustomListDetailViewModel(list!, interactor: interactor!)
        }
    }

}

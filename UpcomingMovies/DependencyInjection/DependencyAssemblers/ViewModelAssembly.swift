//
//  ViewModelAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SavedMoviesViewModelProtocol.self) { (resolver, name: String) in
            let interactor = resolver.resolve(SavedMoviesInteractorProtocol.self, name: name)
            return SavedMoviesViewModel(interactor: interactor!)
        }
    }
    
}

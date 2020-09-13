//
//  SceneAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject

class SceneAssembly: Assembly {
    
    func assemble(container: Container) {
        SavedMoviesAssembly().assemble(container: container)
    }
    
}

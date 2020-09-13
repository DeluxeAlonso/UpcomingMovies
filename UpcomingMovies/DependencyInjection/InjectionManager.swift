//
//  InjectionManager.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject

class InjectionManager {
    
    let container: Container = Container()
    let assembler: Assembler
    
    init() {
        assembler = Assembler(
            [
                DataSourceAssembly(),
                ProviderAssembly()
            ],
            container: container)
    }
    
}

//
//  AdapterAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation
import Swinject

final class AdapterAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ProgressHUDAdapterProtocol.self) { _ in
            ProgressHUDAdapter()
        }.inObjectScope(.container)
    }

}

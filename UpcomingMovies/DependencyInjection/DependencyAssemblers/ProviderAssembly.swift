//
//  ProviderAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/12/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import UpcomingMoviesData
import CoreDataInfrastructure
import NetworkInfrastructure
import Swinject

class ProviderAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UseCaseProviderProtocol.self) { resolver in
            UseCaseProvider(localDataSource: resolver.resolve(LocalDataSourceProtocol.self)!,
                            remoteDataSource: resolver.resolve(RemoteDataSourceProtocol.self)!)
        }
    }
    
}

//
//  ProviderAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/12/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain
import UpcomingMoviesData
import CoreDataInfrastructure
import NetworkInfrastructure
import Swinject

final class ProviderAssembly: Assembly {

    func assemble(container: Container) {
        container.register(UseCaseProviderProtocol.self) { resolver in
            guard let localDataSource = resolver.resolve(LocalDataSourceProtocol.self) else {
                fatalError("LocalDataSourceProtocol dependency could not be resolved")
            }
            guard let remoteDataSource = resolver.resolve(RemoteDataSourceProtocol.self) else {
                fatalError("RemoteDataSourceProtocol dependency could not be resolved")
            }
            return UseCaseProvider(localDataSource: localDataSource, remoteDataSource: remoteDataSource)
        }
    }

}

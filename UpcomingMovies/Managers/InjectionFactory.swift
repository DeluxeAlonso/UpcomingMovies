//
//  InjectionFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/1/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import UpcomingMoviesData
import CoreDataInfrastructure
import NetworkInfrastructure

final class InjectionFactory {
    
    class func useCaseProvider() -> UseCaseProviderProtocol {
        let localDataSource = makeLocalDataSource()
        let remoteDataSource = makeRemoteDataSource()
        return UseCaseProvider(localDataSource: localDataSource,
                               remoteDataSource: remoteDataSource)
    }
    
    class func makeLocalDataSource() -> LocalDataSourceProtocol {
        return LocalDataSource()
    }
    
    class func makeRemoteDataSource() -> RemoteDataSourceProtocol {
        return RemoteDataSource()
    }
    
}

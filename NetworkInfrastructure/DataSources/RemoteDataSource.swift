//
//  RemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesData

final public class RemoteDataSource: RemoteDataSourceProtocol {
    
    public init() {}
    
    public func movieDataSource() -> MovieRemoteDataSourceProtocol {
        let client = MovieClient()
        return MovieRemoteDataSource(client: client)
    }
    
    public func genreDataSource() -> GenreRemoteDataSourceProtocol {
        let client = GenreClient()
        return GenreRemoteDataSource(client: client)
    }
    
    public func accountDataSource() -> AccountRemoteDataSourceProtocol {
        let client = AccountClient()
        return AccountRemoteDataSource(client: client)
    }
    
}

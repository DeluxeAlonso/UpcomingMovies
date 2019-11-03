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
    
    public func genreDataSource() -> GenreRemoteDataSourceProtocol {
        let client = GenreClient()
        return GenreRemoteDataSource(client: client)
    }
    
}

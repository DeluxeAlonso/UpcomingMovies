//
//  ConfigurationRemoteDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public protocol ConfigurationRemoteDataSourceProtocol: AnyObject {

    func getConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void)

}

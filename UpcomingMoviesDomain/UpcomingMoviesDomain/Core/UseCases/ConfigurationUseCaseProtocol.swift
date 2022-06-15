//
//  ConfigurationUseCaseProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

public protocol ConfigurationUseCaseProtocol {

    func getConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void)

}

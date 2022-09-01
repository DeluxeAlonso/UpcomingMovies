//
//  GenreClientProtocol.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

protocol GenreClientProtocol {

    func getAllGenres(completion: @escaping (Result<GenreResult, APIError>) -> Void)

}

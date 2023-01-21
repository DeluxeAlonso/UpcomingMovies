//
//  MovieSearchProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public protocol MovieSearchUseCaseProtocol {

    var didUpdateMovieSearch: (() -> Void)? { get set }

    func getMovieSearches(completion: @escaping (Result<[MovieSearch], Error>) -> Void)
    func save(with searchText: String, completion: @escaping (Result<Void, Error>) -> Void)

}

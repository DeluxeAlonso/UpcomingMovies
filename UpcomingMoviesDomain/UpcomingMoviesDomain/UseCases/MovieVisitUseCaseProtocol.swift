//
//  MovieVisitUseCase.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public protocol MovieVisitUseCaseProtocol {

    var didUpdateMovieVisit: (() -> Void)? { get set }

    func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void)

    func save(with id: Int, title: String, posterPath: String?,
              completion: @escaping (Result<Void, Error>) -> Void)

}

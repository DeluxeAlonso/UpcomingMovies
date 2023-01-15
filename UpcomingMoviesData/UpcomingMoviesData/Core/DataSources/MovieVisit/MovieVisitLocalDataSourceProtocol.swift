//
//  MovieVisitLocalDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public protocol MovieVisitLocalDataSourceProtocol: AnyObject {

    var didUpdateMovieVisit: (() -> Void)? { get set }

    func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void)

    func save(with id: Int, title: String, posterPath: String?,
              completion: @escaping (Result<Void, Error>) -> Void)

}

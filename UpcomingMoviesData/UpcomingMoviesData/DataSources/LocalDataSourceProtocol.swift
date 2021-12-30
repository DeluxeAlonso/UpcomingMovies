//
//  LocalDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public protocol LocalDataSourceProtocol {

    func genreDataSource() -> GenreLocalDataSourceProtocol
    func movieVisitDataSource() -> MovieVisitLocalDataSourceProtocol
    func movieSearchDataSource() -> MovieSearchLocalDataSourceProtocol
    func userDataSource() -> UserLocalDataSourceProtocol

}

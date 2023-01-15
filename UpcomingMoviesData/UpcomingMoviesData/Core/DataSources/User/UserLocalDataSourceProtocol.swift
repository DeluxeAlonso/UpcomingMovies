//
//  UserLocalDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public protocol UserLocalDataSourceProtocol: AnyObject {

    var didUpdateUser: (() -> Void)? { get set }

    func find(with id: Int) -> User?
    func saveUser(_ user: User)

}

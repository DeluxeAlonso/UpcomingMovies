//
//  AuthenticationManagerProtocol.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/3/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol AuthenticationManagerProtocol {

    var readAccessToken: String { get }

    func saveCurrentUser(_ sessionId: String, accountId: Int)
    func deleteCurrentUser()

    func saveRequestToken(_ requestToken: String)
    var requestToken: String? { get }

    func saveAccessToken(_ accessToken: AccessToken)
    var accessToken: AccessToken? { get }

    var userAccount: Account? { get }

}

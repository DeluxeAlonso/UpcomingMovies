//
//  RemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesData

final public class RemoteDataSource: RemoteDataSourceProtocol {

    public init() {}

    public func configure(with apiKey: String, readAccessToken: String) {
        NetworkConfiguration.shared.configure(with: apiKey, and: readAccessToken)
    }

    public func movieDataSource() -> MovieRemoteDataSourceProtocol {
        MovieRemoteDataSource(client: MovieClient())
    }

    public func genreDataSource() -> GenreRemoteDataSourceProtocol {
        GenreRemoteDataSource(client: GenreClient())
    }

    public func accountDataSource() -> AccountRemoteDataSourceProtocol {
        AccountRemoteDataSource(client: AccountClient())
    }

    public func authDataSource() -> AuthRemoteDataSourceProtocol {
        AuthRemoteDataSource(authClient: AuthClient(), accountClient: AccountClient())
    }

    public func configurationDataSource() -> ConfigurationRemoteDataSourceProtocol {
        ConfigurationRemoteDataSource(client: ConfigurationClient())
    }

}

//
//  DataSourceAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/12/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesData
import CoreDataInfrastructure
import NetworkInfrastructure
import Swinject

final class DataSourceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LocalDataSourceProtocol.self) { _ in
            return LocalDataSource()
        }
        container.register(RemoteDataSourceProtocol.self) { _ in
            let remoteDataSource = RemoteDataSource()
            remoteDataSource.configure(with: "0141e6d543b187f0b7e6bb3a1902209a", readAccessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTQxZTZkNTQzYjE4N2YwYjdlNmJiM2ExOTAyMjA5YSIsInN1YiI6IjVjNDkwZjlhYzNhMzY4NDc3Nzg5ZjYzMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5LmQZ0jl7xA7QsREDm8FecIKq9yP0hSZ3x2MDTEn5dU")
            return remoteDataSource
        }
    }
    
}

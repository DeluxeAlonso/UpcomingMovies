//
//  LocalDataSource.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesData

final public class LocalDataSource: LocalDataSourceProtocol {

    private let coreDataStack: CoreDataStackProtocol

    // MARK: - Initializers

    public init(appGroupExtensions: [String] = []) {
        self.coreDataStack = CoreDataStack.shared
        self.coreDataStack.setExtensionPersistentStoreDescriptions(appGroupExtensions)
    }

    // MARK: - LocalDataSourceProtocol

    public func genreDataSource() -> GenreLocalDataSourceProtocol {
        let store: PersistenceStore<CDGenre> = PersistenceStore(self.coreDataStack.persistentContainer)
        return GenreLocalDataSource(store: store)
    }

    public func movieVisitDataSource() -> MovieVisitLocalDataSourceProtocol {
        let store: PersistenceStore<CDMovieVisit> = PersistenceStore(self.coreDataStack.persistentContainer)
        return MovieVisitLocalDataSource(store: store)
    }

    public func movieSearchDataSource() -> MovieSearchLocalDataSourceProtocol {
        let store: PersistenceStore<CDMovieSearch> = PersistenceStore(self.coreDataStack.persistentContainer)
        return MovieSearchLocalDataSource(store: store)
    }

    public func userDataSource() -> UserLocalDataSourceProtocol {
        let store: PersistenceStore<CDUser> = PersistenceStore(self.coreDataStack.persistentContainer)
        return UserLocalDataSource(store: store)
    }

}

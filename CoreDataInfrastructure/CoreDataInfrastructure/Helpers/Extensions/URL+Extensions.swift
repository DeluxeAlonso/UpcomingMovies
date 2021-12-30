//
//  URL+Extensions.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 5/9/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

extension URL {

    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }

}

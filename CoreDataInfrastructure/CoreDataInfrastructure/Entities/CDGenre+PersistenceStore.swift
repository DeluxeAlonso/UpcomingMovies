//
//  PersistenceStore+Genre.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

extension PersistenceStore where Entity == CDGenre {

    func saveGenre(_ genre: Genre, completion: ((Bool) -> Void)? = nil) {
        managedObjectContext.performChanges {
            _ = CDGenre.insert(into: self.managedObjectContext,
                               id: genre.id,
                               name: genre.name)
            completion?(true)
        }
    }

    func find(with id: Int) -> CDGenre? {
        let predicate = NSPredicate(format: "id == %d", id)
        return CDGenre.findOrFetch(in: managedObjectContext, matching: predicate)
    }

    func findAll() -> [CDGenre] {
        CDGenre.fetch(in: managedObjectContext)
    }

}

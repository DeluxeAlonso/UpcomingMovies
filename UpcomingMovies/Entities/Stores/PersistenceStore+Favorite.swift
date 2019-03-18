//
//  PersistenceStore+Favorite.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

extension PersistenceStore where Entity == Favorite {
    
    // MARK: - Queries
    
    func find(with id: Int) -> Favorite? {
        let predicate = NSPredicate(format: "id == %d", id)
        return Favorite.findOrFetch(in: managedObjectContext, matching: predicate)
    }
    
    func exist(with id: Int) -> Bool {
        return find(with: id) != nil
    }
    
    // MARK: - Save
    
    func saveFavorite(with id: Int, title: String, backdropPath: String?) {
        managedObjectContext.performChanges {
            _ = Favorite.insert(into: self.managedObjectContext,
                                id: id,
                                title: title,
                                backdropPath: backdropPath)
        }
    }
    
    // MARK: - Delete
    
    func removeFavorite(with id: Int) {
        guard let favorite = find(with: id) else { return }
        favorite.managedObjectContext?.performChanges {
            favorite.managedObjectContext?.delete(favorite)
        }
    }
    
}

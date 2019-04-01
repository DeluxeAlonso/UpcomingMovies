//
//  PersistenceStore+User.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

extension PersistenceStore where Entity == User {
    
    func find(with id: Int) -> User? {
        let predicate = NSPredicate(format: "id == %d", id)
        return User.findOrFetch(in: managedObjectContext, matching: predicate)
    }
    
}

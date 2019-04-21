//
//  PersistenceStore+Genre.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

extension PersistenceStore where Entity == Genre {
    
    func find(with id: Int) -> Genre? {
        let predicate = NSPredicate(format: "id == %d", id)
        return Genre.findOrFetch(in: managedObjectContext, matching: predicate)
    }
    
    func findAll() -> [Genre] {
        return Genre.fetch(in: managedObjectContext)
    }
    
}

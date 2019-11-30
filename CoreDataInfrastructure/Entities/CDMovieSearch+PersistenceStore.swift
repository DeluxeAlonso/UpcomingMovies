//
//  PersistenceStore+MovieSearch.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

extension PersistenceStore where Entity == CDMovieSearch {
    
    func saveMovieSearch(with searchText: String, completion: ((Bool) -> Void)? = nil) {
        managedObjectContext.performChanges {
            _ = CDMovieSearch.insert(into: self.managedObjectContext,
                                     searchText: searchText)
            completion?(true)
        }
    }
    
}

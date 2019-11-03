//
//  PersistenceStore+MovieSearch.swift
//  CoreDataInfraestructure
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

extension PersistenceStore where Entity == CDMovieSearch {
    
    func saveMovieSearch(with searchText: String) {
        managedObjectContext.performChanges {
            _ = CDMovieSearch.insert(into: self.managedObjectContext,
                                     searchText: searchText)
        }
    }
    
}

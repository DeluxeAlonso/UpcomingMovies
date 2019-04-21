//
//  PersistenceStore+MovieSearch.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

extension PersistenceStore where Entity == MovieSearch {
    
    func saveMovieSearch(with searchText: String) {
        managedObjectContext.performChanges {
            _ = MovieSearch.insert(into: self.managedObjectContext,
                                   searchText: searchText)
        }
    }
    
}

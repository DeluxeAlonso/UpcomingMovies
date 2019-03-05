//
//  PersistenceStore+MovieVisit.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

extension PersistenceStore where Entity == MovieVisit {
    
    func saveMovieVisit(with id: Int, title: String, posterPath: String?) {
        guard let posterPath = posterPath else { return }
        managedObjectContext.performChanges {
            _ = MovieVisit.insert(into: self.managedObjectContext,
                                  id: id,
                                  title: title,
                                  posterPath: posterPath)
        }
    }

}

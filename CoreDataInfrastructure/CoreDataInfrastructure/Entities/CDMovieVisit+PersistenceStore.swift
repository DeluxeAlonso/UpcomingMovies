//
//  PersistenceStore+MovieVisit.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

extension PersistenceStore where Entity == CDMovieVisit {
    
    func saveMovieVisit(with id: Int, title: String, posterPath: String?, completion: ((Bool) -> Void)? = nil) {
        guard let posterPath = posterPath else {
            completion?(false)
            return
        }
        managedObjectContext.performChanges {
            _ = CDMovieVisit.insert(into: self.managedObjectContext,
                                    id: id,
                                    title: title,
                                    posterPath: posterPath)
            completion?(true)
        }
    }
    
    func exists() -> Bool {
        return countAll() > 0
    }

    func findAll(completion: (([CDMovieVisit]) -> Void)? = nil) {
        let context = createBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.performAndWait {
            let movieVisits = CDMovieVisit.fetch(in: managedObjectContext)
            completion?(movieVisits)
        }
    }
    
    func countAll() -> Int {
        return CDMovieVisit.count(in: managedObjectContext)
    }

}

//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class MovieDetailViewModel {
    
    var id: Int
    var title: String
    var genre: String?
    var releaseDate: String?
    var posterPath: String?
    var fullBackdropPath: URL?
    var overview: String?
    
    // MARK: - Initializers

    init(_ movie: Movie) {
        id = movie.id
        title = movie.title
        genre = movie.genreName
        releaseDate = movie.releaseDate
        overview = movie.overview
        posterPath = movie.posterPath
        if let backdropPath = movie.backdropPath {
            fullBackdropPath = URL(string: URLConfiguration.mediaBackdropPath + backdropPath)
        }
    }
    
    // MARK: - Public
    
    func saveVisitedMovie(_ managedObjectContext: NSManagedObjectContext) {
        guard let posterPath = posterPath else { return }
        managedObjectContext.performChanges {
            _ = MovieVisit.insert(into: managedObjectContext,
                                  id: self.id,
                                  title: self.title,
                                  posterPath: posterPath)
        }
    }
    
}

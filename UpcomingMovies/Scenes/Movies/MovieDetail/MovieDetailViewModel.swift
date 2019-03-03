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
    var releaseDate: String
    var overview: String
    var voteAverage: Double?
    var posterPath: String?
    var posterURL: URL?
    var backdropPath: String?
    var backdropURL: URL?
    
    // MARK: - Initializers

    init(_ movie: Movie) {
        id = movie.id
        title = movie.title
        genre = movie.genreName
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        posterPath = movie.posterPath
        posterURL = movie.posterURL
        backdropPath = movie.backdropPath
        backdropURL = movie.backdropURL
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
    
    func saveFavoriteMovie(_ managedObjectContext: NSManagedObjectContext) {
        guard let backdropPath = backdropPath else { return }
        managedObjectContext.performChanges {
            _ = Favorite.insert(into: managedObjectContext,
                                  id: self.id,
                                  title: self.title,
                                  backdropPath: backdropPath)
        }
    }
    
    // MARK: - View Models Building
    
    func buildVideosViewModel() -> MovieVideosViewModel {
        return MovieVideosViewModel(movieId: self.id, movieTitle: self.title)
    }
    
    func buildReviewsViewModel() -> MovieReviewsViewModel {
        return MovieReviewsViewModel(movieId: self.id, movieTitle: self.title)
    }
    
    func buildCreditsViewModel() -> MovieCreditsViewModel {
        return MovieCreditsViewModel(movieId: self.id, movieTitle: self.title)
    }
    
    func buildSimilarsViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .similar(movieId: self.id))
    }
    
}

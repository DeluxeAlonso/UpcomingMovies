//
//  CustomListDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class CustomListDetailViewModel {
    
    private let managedObjectContext: NSManagedObjectContext
    
    let id: Int
    let name: String
    let description: String?
    let movieCount: Int
    var posterURL: URL?
    
    // MARK: - Initializers
    
    init(_ list: List, managedObjectContext: NSManagedObjectContext) {
        id = list.id
        name = list.name
        description = list.description
        movieCount = list.movieCount
        posterURL = list.posterURL
        self.managedObjectContext = managedObjectContext
    }
    
    // MARK: - Public
    
    func buildHeaderViewModel() -> CustomListDetailHeaderViewModel {
        return CustomListDetailHeaderViewModel(name: name,
                                               description: description,
                                               posterURL: posterURL)
    }
    
    func buildSectionViewModel() -> CustomListDetailSectionViewModel {
        return CustomListDetailSectionViewModel(movieCount: movieCount)
    }
    
}

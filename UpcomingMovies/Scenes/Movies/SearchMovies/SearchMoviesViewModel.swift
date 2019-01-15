//
//  SearchMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class SearchMoviesViewModel: NSObject {
    
    func searchOptionsViewModel(_ managedObjectContext: NSManagedObjectContext) -> SearchOptionsViewModel {
        return SearchOptionsViewModel(managedObjectContext: managedObjectContext)
    }
    
    func prepareSearchResultController(_ managedObjectContext: NSManagedObjectContext) -> SearchMoviesResultController {
        let viewModel = SearchMoviesResultViewModel(managedObjectContext: managedObjectContext)
        return SearchMoviesResultController(viewModel: viewModel)
    }
    
}

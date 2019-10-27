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
    private let accountClient = AccountClient()
    private let authManager = AuthenticationManager.shared
    
    private let id: String
    let name: String
    private let description: String?
    private let movieCount: Int
    private let rating: Double?
    private let runtime: Int?
    private var backdropURL: URL?
    
    // MARK: - Reactive properties
    
    let viewState: Bindable<ViewState> = Bindable(.loading)
    
    // MARK: - Computed properties
    
    private var movies: [Movie] {
        return viewState.value.currentMovies
    }
    
    var movieCells: [MovieCellViewModel] {
        return movies.map { MovieCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(_ list: List, managedObjectContext: NSManagedObjectContext) {
        id = list.id
        name = list.name
        description = list.description
        movieCount = list.movieCount
        rating = list.averageRating
        runtime = list.runtime
        backdropURL = list.backdropURL
        self.managedObjectContext = managedObjectContext
    }
    
    // MARK: - Public
    
    func buildHeaderViewModel() -> CustomListDetailHeaderViewModel {
        return CustomListDetailHeaderViewModel(name: name,
                                               description: description,
                                               posterURL: backdropURL)
    }
    
    func buildSectionViewModel() -> CustomListDetailSectionViewModel {
        return CustomListDetailSectionViewModel(movieCount: movieCount, rating: rating, runtime: runtime)
    }
    
    func buildDetailViewModel(at index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        return MovieDetailViewModel(movies[index])
    }
    
    // MARK: - Networking
    
    func getListMovies() {
        guard let accessToken = authManager.accessToken else { return }
        accountClient.getCustomListMovies(with: accessToken.token, listId: id, completion: { result in
            switch result {
            case .success(let movieResult):
                self.processListMovies(movieResult?.results)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processListMovies(_ movies: [Movie]?) {
        guard let movies = movies, !movies.isEmpty else {
            viewState.value = .empty
            return
        }
        viewState.value = .populated(movies)
    }
    
}

// MARK: - View State

extension CustomListDetailViewModel {
    
    enum ViewState {
        case loading
        case empty
        case populated([Movie])
        case error(ErrorDescriptable)
        
        var currentMovies: [Movie] {
            switch self {
            case .loading, .empty, .error:
                return []
            case .populated(let movies):
                return movies
            }
        }
        
    }
    
}

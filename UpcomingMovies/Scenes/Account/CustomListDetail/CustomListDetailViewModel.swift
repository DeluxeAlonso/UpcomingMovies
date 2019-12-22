//
//  CustomListDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class CustomListDetailViewModel {
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let accountUseCase: AccountUseCaseProtocol
    
    private let id: String
    private let description: String?
    private let movieCount: Int
    private let rating: Double?
    private let runtime: Int?
    private var backdropURL: URL?
    
    let name: String
    
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
    
    init(_ list: List, useCaseProvider: UseCaseProviderProtocol) {
        id = list.id
        name = list.name
        description = list.description
        movieCount = list.movieCount
        rating = list.averageRating
        runtime = list.runtime
        backdropURL = list.backdropURL
        
        self.useCaseProvider = useCaseProvider
        self.accountUseCase = self.useCaseProvider.accountUseCase()
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
        return MovieDetailViewModel(movies[index], useCaseProvider: useCaseProvider)
    }
    
    // MARK: - Networking
    
    func getListMovies() {
        accountUseCase.getCustomListMovies(listId: id, completion: { result in
            switch result {
            case .success(let movies):
                self.processListMovies(movies)
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
        case error(Error)
        
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

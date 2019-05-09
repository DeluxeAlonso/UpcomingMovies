//
//  CollectionListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class CollectionListViewModel {
    
    private let managedObjectContext: NSManagedObjectContext
    private let collectionOption: ProfileCollectionOption
    
    private let accountClient = AccountClient()
    
    private let userCredentials = AuthenticationManager.shared.userCredentials()
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    var movies: [Movie] {
        return viewState.value.currentEntities
    }
    
    var movieCells: [ProfileMovieCellViewModel] {
        return movies.compactMap { ProfileMovieCellViewModel($0) }
    }
    
    let title: String?
    
    // MARK: - Initializers
    
    init(managedObjectContext: NSManagedObjectContext, collectionOption: ProfileCollectionOption) {
        self.managedObjectContext = managedObjectContext
        self.collectionOption = collectionOption
        self.title = collectionOption.title
    }
    
    // MARK: - Public
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        let movie = movies[index]
        return MovieDetailViewModel(id: movie.id,
                                    title: movie.title,
                                    managedObjectContext: managedObjectContext)
    }
    
    // MARK: - Networking
    
    func getCollectionList() {
        let showLoader = viewState.value.isInitialPage
        fetchCollectionList(page: viewState.value.currentPage, option: collectionOption, showLoader: showLoader)
    }
    
    func refreshCollectionList() {
        fetchCollectionList(page: 1, option: collectionOption, showLoader: false)
    }
    
    func fetchCollectionList(page: Int, option: ProfileCollectionOption, showLoader: Bool) {
        guard let credentials = userCredentials else { return }
        startLoading.value = showLoader
        accountClient.getCollectionList(page: page, option: option,
                                        sessionId: credentials.sessionId,
                                        accountId: credentials.accountId) { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                self.processMovieResult(movieResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    private func processMovieResult(_ movieResult: MovieResult) {
        startLoading.value = false
        var allMovies = movieResult.currentPage == 1 ? [] : viewState.value.currentEntities
        allMovies.append(contentsOf: movieResult.results)
        guard !allMovies.isEmpty else {
            viewState.value = .empty
            return
        }
        if movieResult.hasMorePages {
            viewState.value = .paging(allMovies, next: movieResult.nextPage)
        } else {
            viewState.value = .populated(allMovies)
        }
    }
    
}

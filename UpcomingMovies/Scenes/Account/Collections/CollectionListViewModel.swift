//
//  CollectionListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class CollectionListViewModel {
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let accountUseCase: AccountUseCaseProtocol
    
    private let collectionOption: ProfileCollectionOption
    
    private let authManager = AuthenticationManager.shared
    
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
    
    init(useCaseProvider: UseCaseProviderProtocol, collectionOption: ProfileCollectionOption) {
        self.useCaseProvider = useCaseProvider
        self.accountUseCase = self.useCaseProvider.accountUseCase()
        
        self.collectionOption = collectionOption
        self.title = collectionOption.title
    }
    
    // MARK: - Public
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        let movie = movies[index]
        return MovieDetailViewModel(id: movie.id,
                                    title: movie.title,
                                    useCaseProvider: useCaseProvider)
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
        startLoading.value = showLoader
        accountUseCase.getCollectionList(option: option, page: page, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let movies):
                self.processMovieResult(movies, currentPage: self.viewState.value.currentPage)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processMovieResult(_ movies: [Movie], currentPage: Int) {
        var allMovies = currentPage == 1 ? [] : viewState.value.currentEntities
        allMovies.append(contentsOf: movies)
        guard !allMovies.isEmpty else {
            viewState.value = .empty
            return
        }
        if movies.isEmpty {
            viewState.value = .populated(allMovies)
        } else {
            viewState.value = .paging(allMovies, next: currentPage + 1)
        }
    }
    
}

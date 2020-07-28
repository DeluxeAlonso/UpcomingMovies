//
//  CustomListDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class CustomListDetailViewModel: CustomListDetailViewModelProtocol {

    private let list: List
    private let interactor: CustomListDetailInteractorProtocol
    
    // MARK: - Reactive properties
    
    let viewState: Bindable<CustomListDetailViewState> = Bindable(.loading)
    
    // MARK: - Computed properties
    
    private var movies: [Movie] {
        return viewState.value.currentMovies
    }
    
    var movieCells: [MovieCellViewModel] {
        return movies.map { MovieCellViewModel($0) }
    }
    
    var listName: String? {
        return self.list.name
    }
    
    // MARK: - Initializers
    
    init(_ list: List, interactor: CustomListDetailInteractorProtocol) {
        self.list = list
        self.interactor = interactor
    }
    
    // MARK: - Public
    
    func buildHeaderViewModel() -> CustomListDetailHeaderViewModelProtocol {
        return CustomListDetailHeaderViewModel(list: list)
    }
    
    func buildSectionViewModel() -> CustomListDetailSectionViewModel {
        return CustomListDetailSectionViewModel(list: list)
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    // MARK: - Networking
    
    func getListMovies() {
        interactor.getCustomListMovies(listId: list.id, completion: { result in
            self.viewState.value = self.processResult(result)
        })
    }
    
    private func processResult(_ result: Result<[Movie], Error>) -> CustomListDetailViewState {
        switch result {
        case .success(let movies):
            guard !movies.isEmpty else { return .empty }
            return .populated(movies)
        case .failure(let error):
            return .error(error)
        }
    }

}

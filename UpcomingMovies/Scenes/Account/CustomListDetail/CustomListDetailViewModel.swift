//
//  CustomListDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class CustomListDetailViewModel: CustomListDetailViewModelProtocol {

    // MARK: - Dependencies

    private let list: ListProtocol
    private let interactor: CustomListDetailInteractorProtocol

    // MARK: - Reactive properties

    let viewState = BehaviorBindable(CustomListDetailViewState.loading).eraseToAnyBindable()

    // MARK: - Computed properties

    var emptyMovieResultsTitle: String {
        LocalizedStrings.emptyMovieResults()
    }

    private var movies: [MovieProtocol] {
        viewState.value.currentMovies
    }

    var movieCells: [MovieListCellViewModel] {
        movies.map { MovieListCellViewModel($0) }
    }

    var listName: String? {
        list.name
    }

    // MARK: - Initializers

    init(_ list: ListProtocol, interactor: CustomListDetailInteractorProtocol) {
        self.list = list
        self.interactor = interactor
    }

    // MARK: - CustomListDetailViewModelProtocol

    func buildHeaderViewModel() -> CustomListDetailHeaderViewModelProtocol {
        CustomListDetailHeaderViewModel(list: list)
    }

    func buildSectionViewModel() -> CustomListDetailSectionViewModel {
        CustomListDetailSectionViewModel(list: list)
    }

    func movie(at index: Int) -> MovieProtocol {
        movies[index]
    }

    func getListMovies() {
        interactor.getCustomListMovies(listId: list.id, completion: { result in
            switch result {
            case .success(let movies):
                self.viewState.value = self.processResult(movies)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }

    // MARK: - Private

    private func processResult(_ movies: [MovieProtocol]) -> CustomListDetailViewState {
        guard !movies.isEmpty else { return .empty }

        return .populated(movies)
    }

}

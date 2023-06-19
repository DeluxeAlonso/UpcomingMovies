//
//  CustomListDetailMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 14/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MockCustomListDetailInteractor: CustomListDetailInteractorProtocol {

    var getCustomListMoviesCallCount = 0
    var getCustomListMoviesResult: Result<[Movie], Error>?
    func getCustomListMovies(listId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let getCustomListMoviesResult {
            completion(getCustomListMoviesResult)
        }
        getCustomListMoviesCallCount += 1
    }

}

final class MockCustomListDetailViewModel: CustomListDetailViewModelProtocol {

    var listName: String?

    var viewState: AnyBehaviorBindable<CustomListDetailViewState> = BehaviorBindable<CustomListDetailViewState>(.empty).eraseToAnyBindable()

    var movieCells: [MovieCellViewModel] = []

    var buildHeaderViewModelCallCount = 0
    var buildHeaderViewModelResult = CustomListDetailHeaderViewModel(list: .with())
    func buildHeaderViewModel() -> CustomListDetailHeaderViewModelProtocol {
        buildHeaderViewModelCallCount += 1
        return buildHeaderViewModelResult
    }

    var buildSectionViewModelCallCount = 0
    var buildSectionViewModelResult = CustomListDetailSectionViewModel(list: .with())
    func buildSectionViewModel() -> CustomListDetailSectionViewModel {
        buildSectionViewModelCallCount += 1
        return buildSectionViewModelResult
    }

    var movieAtIndexCallCount = 0
    var movieAtIndexResult: Movie = .with()
    func movie(at index: Int) -> Movie {
        movieAtIndexCallCount += 1
        return movieAtIndexResult
    }

    var getListMoviesCallCount = 0
    func getListMovies() {
        getListMoviesCallCount += 1
    }

}

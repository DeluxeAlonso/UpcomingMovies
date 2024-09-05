//
//  SearchMoviesMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class SearchOptionsInteractorMock: SearchOptionsInteractorProtocol {

    var didUpdateMovieVisit: (() -> Void)?

    var getGenresResult: Result<[GenreProtocol], Error>?
    private(set) var getGenresCallCount = 0
    func getGenres(completion: @escaping (Result<[GenreProtocol], Error>) -> Void) {
        if let getGenresResult = getGenresResult {
            completion(getGenresResult)
        }
        getGenresCallCount += 1
    }

    var getMovieVisitsResult: Result<[MovieVisitProtocol], Error>?
    private(set) var getMovieVisitsCallCount = 0
    func getMovieVisits(completion: @escaping (Result<[MovieVisitProtocol], Error>) -> Void) {
        if let getMovieVisitsResult = getMovieVisitsResult {
            completion(getMovieVisitsResult)
        }
        getMovieVisitsCallCount += 1
    }

}

final class MockSearchMoviesResultControllerDelegate: MockViewController, SearchMoviesResultControllerDelegate {

    var didSelectRecentSearch = 0
    func searchMoviesResultController(_ searchMoviesResultController: SearchMoviesResultController, didSelectRecentSearch searchText: String) {
        didSelectRecentSearch += 1
    }

}

final class MockSearchMoviesResultInteractor: SearchMoviesResultInteractorProtocol {
    var didUpdateMovieSearches: (() -> Void)?

    var searchMoviesResult: Result<[MovieProtocol], Error>?
    private(set) var searchMoviesCallCount = 0
    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        if let searchMoviesResult = searchMoviesResult {
            completion(searchMoviesResult)
        }
        searchMoviesCallCount += 1
    }

    var getMovieSearchesResult: Result<[MovieSearchProtocol], Error>?
    private(set) var getMovieSearchesCallCount = 0
    func getMovieSearches(limit: Int?, completion: @escaping (Result<[MovieSearchProtocol], Error>) -> Void) {
        if let getMovieSearchesResult = getMovieSearchesResult {
            completion(getMovieSearchesResult)
        }
        getMovieSearchesCallCount += 1
    }

    var saveSearchTextResult: Result<Void, Error>?
    private(set) var saveSearchTextCallCount = 0
    func saveSearchText(_ searchText: String, completion: ((Result<Void, Error>) -> Void)?) {
        if let saveSearchTextResult = saveSearchTextResult {
            completion?(saveSearchTextResult)
        }
        saveSearchTextCallCount += 1
    }

}

final class MockSearchOptionsViewModel: SearchOptionsViewModelProtocol {

    var viewState: BehaviorBindable<SearchOptionsViewState> = .init(.emptyMovieVisits)

    var needsContentReload: PublishBindable<Void> = .init()

    var updateVisitedMovies: PublishBindable<Int> = .init()

    var selectedDefaultSearchOption: PublishBindable<DefaultSearchOption> = .init()

    var selectedMovieGenre: PublishBindable<(Int, String)> = .init()

    var selectedRecentlyVisitedMovie: PublishBindable<(Int, String)> = .init()

    var visitedMovieCells: [VisitedMovieCellViewModelProtocol] = .init()

    var genreCells: [GenreSearchOptionCellViewModelProtocol] = .init()

    var defaultSearchOptionsCells: [DefaultSearchOptionCellViewModelProtocol] = []

    private(set) var loadGenresCallCount = 0
    func loadGenres() {
        loadGenresCallCount += 1
    }

    private(set) var loadVisitedMoviesCallCount = 0
    func loadVisitedMovies() {
        loadVisitedMoviesCallCount += 1
    }

    var sectionAtIndexResult: SearchOptionsSection = .defaultSearches
    private(set) var sectionAtIndexCallCount = 0
    func section(at index: Int) -> SearchOptionsSection {
        sectionAtIndexCallCount += 1
        return sectionAtIndexResult
    }

    var sectionIndexResult: Int?
    private(set) var sectionIndexCallCount = 0
    func sectionIndex(for section: SearchOptionsSection) -> Int? {
        sectionIndexCallCount += 1
        return sectionIndexResult
    }

    var buildRecentlyVisitedMoviesCellResult: RecentlyVisitedMoviesCellViewModelProtocol = RecentlyVisitedMoviesCellViewModel(visitedMovieCells: [])
    private(set) var buildRecentlyVisitedMoviesCellCallCount = 0
    func buildRecentlyVisitedMoviesCell() -> RecentlyVisitedMoviesCellViewModelProtocol {
        buildRecentlyVisitedMoviesCellCallCount += 1
        return buildRecentlyVisitedMoviesCellResult
    }

    private(set) var getDefaultSearchSelectionCallCount = 0
    func getDefaultSearchSelection(by index: Int) {
        getDefaultSearchSelectionCallCount += 1
    }

    private(set) var getMovieGenreSelectionCallCount = 0
    func getMovieGenreSelection(by index: Int) {
        getMovieGenreSelectionCallCount += 1
    }

    // swiftlint:disable identifier_name
    private(set) var getRecentlyVisitedMovieSelectionCallCount = 0
    func getRecentlyVisitedMovieSelection(by index: Int) {
        getRecentlyVisitedMovieSelectionCallCount += 1
    }

}

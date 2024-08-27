//
//  SearchMoviesProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol SearchMoviesCoordinatorProtocol: AnyObject, MovieDetailCoordinable {

    func embedSearchOptions(on parentViewController: UIViewController,
                            in containerView: UIView) -> SearchOptionsViewController

    func embedSearchController(on parentViewController: SearchMoviesResultControllerDelegate) -> SearchController

    func showMovieDetail(for movieId: Int, and movieTitle: String)
    func showMoviesByGenre(_ genreId: Int, genreName: String)
    func showDefaultSearchOption(_ option: DefaultSearchOption)

}

// MARK: - Search movies result

protocol SearchMoviesResultViewModelProtocol {

    var viewState: AnyBehaviorBindable<SearchMoviesResultViewState> { get }
    var needsRefresh: AnyPublishBindable<Void> { get }

    var recentSearchCells: [RecentSearchCellViewModelProtocol] { get }
    var movieCells: [MovieListCellViewModelProtocol] { get }

    var emptySearchResultsTitle: String { get }
    var recentSearchesTitle: String { get }

    func loadRecentSearches()

    func searchMovies(withSearchText searchText: String)
    func searchedMovie(at index: Int) -> MovieProtocol

    func clearMovies()

}

protocol SearchMoviesResultInteractorProtocol {

    var didUpdateMovieSearches: (() -> Void)? { get set }

    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[MovieProtocol], Error>) -> Void)

    func getMovieSearches(limit: Int?,
                          completion: @escaping (Result<[MovieSearchProtocol], Error>) -> Void)
    func saveSearchText(_ searchText: String, completion: ((Result<Void, Error>) -> Void)?)

}

// MARK: - Search options

protocol SearchOptionsViewModelProtocol {

    var viewState: BehaviorBindable<SearchOptionsViewState> { get }
    var needsContentReload: PublishBindable<Void> { get }
    var updateVisitedMovies: PublishBindable<Int> { get }

    var selectedDefaultSearchOption: PublishBindable<DefaultSearchOption> { get }
    var selectedMovieGenre: PublishBindable<(Int, String)> { get }
    var selectedRecentlyVisitedMovie: PublishBindable<(Int, String)> { get }

    var visitedMovieCells: [VisitedMovieCellViewModelProtocol] { get }
    var genreCells: [GenreSearchOptionCellViewModelProtocol] { get }

    var defaultSearchOptionsCells: [DefaultSearchOptionCellViewModelProtocol] { get }

    func loadGenres()
    func loadVisitedMovies()

    func section(at index: Int) -> SearchOptionsSection
    func sectionIndex(for section: SearchOptionsSection) -> Int?

    func buildRecentlyVisitedMoviesCell() -> RecentlyVisitedMoviesCellViewModelProtocol

    func getDefaultSearchSelection(by index: Int)
    func getMovieGenreSelection(by index: Int)
    func getRecentlyVisitedMovieSelection(by index: Int)

}

protocol SearchOptionsInteractorProtocol {

    var didUpdateMovieVisit: (() -> Void)? { get set }

    func getGenres(completion: @escaping (Result<[GenreProtocol], Error>) -> Void)
    func getMovieVisits(completion: @escaping (Result<[MovieVisitProtocol], Error>) -> Void)

}

protocol SearchOptionsViewControllerDelegate: UIViewController {

    func searchOptionsViewController(_ searchOptionsViewController: SearchOptionsViewController,
                                     didSelectDefaultSearchOption option: DefaultSearchOption)

    func searchOptionsViewController(_ searchOptionsViewController: SearchOptionsViewController,
                                     didSelectMovieGenreWithId genreId: Int, andGenreName genreName: String)

    func searchOptionsViewController(_ searchOptionsViewController: SearchOptionsViewController,
                                     didSelectRecentlyVisitedMovie id: Int,
                                     title: String)

}

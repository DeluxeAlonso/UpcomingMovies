//
//  SearchMoviesProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol SearchMoviesCoordinatorProtocol: AnyObject {

    func embedSearchOptions(on parentViewController: UIViewController,
                            in containerView: UIView) -> SearchOptionsViewController

    func embedSearchController(on parentViewController: SearchMoviesResultControllerDelegate) -> SearchController

    func showMovieDetail(for movie: Movie)
    func showMovieDetail(for movieId: Int, and movieTitle: String)
    func showMoviesByGenre(_ genreId: Int, genreName: String)
    func showDefaultSearchOption(_ option: DefaultSearchOption)

}

// MARK: - Search movies result

protocol SearchMoviesResultViewModelProtocol {

    var viewState: Bindable<SearchMoviesResultViewState> { get }

    var recentSearchCells: [RecentSearchCellViewModelProtocol] { get }
    var movieCells: [MovieListCellViewModelProtocol] { get }

    func searchMovies(withSearchText searchText: String)
    func searchedMovie(at index: Int) -> Movie

    func clearMovies()

}

protocol SearchMoviesResultInteractorProtocol {

    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void)

    func getMovieSearches() -> [MovieSearch]
    func saveSearchText(_ searchText: String)

}

// MARK: - Search options

protocol SearchOptionsViewModelProtocol {

    var viewState: Bindable<SearchOptionsViewState> { get }
    var needsContentReload: Bindable<Void> { get }
    var updateVisitedMovies: Bindable<Int?> { get }

    var selectedDefaultSearchOption: Bindable<DefaultSearchOption?> { get }
    var selectedMovieGenre: Bindable<(Int?, String?)> { get }
    var selectedRecentlyVisitedMovie: ((Int, String) -> Void)? { get set }

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

    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
    func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void)

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

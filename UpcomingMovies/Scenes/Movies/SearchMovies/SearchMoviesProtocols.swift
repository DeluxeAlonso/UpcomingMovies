//
//  SearchMoviesProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol SearchMoviesCoordinatorProtocol: class {
    
    @discardableResult
    func embedSearchOptions(on parentViewController: UIViewController,
                            in containerView: UIView) -> SearchOptionsTableViewController
    
    @discardableResult
    func embedSearchController(on parentViewController: SearchMoviesResultControllerDelegate) -> DefaultSearchController

    func showMovieDetail(for movie: Movie)
    func showMovieDetail(for movieId: Int, and movieTitle: String)
    func showPopularMovies()
    func showTopRatedMovies()
    func showMoviesByGenre(_ genreId: Int, genreName: String)
    
}

// MARK: - Search movies result

protocol SearchMoviesResultViewModelProtocol {
    
    var viewState: Bindable<SearchMoviesResultViewState> { get }
    var updateRecentSearches: (() -> Void)? { get set }
    
    var recentSearchCells: [RecentSearchCellViewModel] { get }
    var movieCells: [MovieCellViewModel] { get }
    
    func searchMovies(withSearchText searchText: String)
    func searchedMovie(at index: Int) -> Movie
    
    func resetViewState()
    func clearMovies()
    
}

protocol SearchMoviesResultInteractorProtocol {
    
    var didUpdateMovieSearch: (() -> Void)? { get set }
    
    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getMovieSearches() -> [MovieSearch]
    func saveSearchText(_ searchText: String)
    
}

// MARK: - Search options

protocol SearchOptionsViewModelProtocol {
    
    var viewState: Bindable<SearchOptionsViewState> { get }
    var needsContentReload: (() -> Void)? { get set }
    var updateVisitedMovies: Bindable<Int?> { get }
    
    var selectedDefaultSearchOption: Bindable<DefaultSearchOption?> { get }
    var selectedMovieGenre: Bindable<(Int?, String?)> { get }
    var selectedRecentlyVisitedMovie: ((Int, String) -> Void)? { get set }
    
    var visitedMovieCells: [VisitedMovieCellViewModel] { get }
    var genreCells: [GenreSearchOptionCellViewModel] { get }
    
    var defaultSearchOptionsCells: [DefaultSearchOptionCellViewModel] { get }
    
    func load()
    
    func section(at index: Int) -> SearchOptionsSection
    func sectionIndex(for section: SearchOptionsSection) -> Int?
    
    func buildRecentlyVisitedMoviesCell() -> RecentlyVisitedMoviesCellViewModel
    
    func getDefaultSearchSelection(by index: Int)
    func getMovieGenreSelection(by index: Int)
    func getRecentlyVisitedMovieSelection(by index: Int)
    
}

protocol SearchOptionsTableViewControllerDelegate: UIViewController {
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController, didSelectPopularMovies selected: Bool)
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectTopRatedMovies selected: Bool)
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectMovieGenreWithId genreId: Int, andGenreName genreName: String)
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectRecentlyVisitedMovie id: Int,
                                          title: String)
    
}

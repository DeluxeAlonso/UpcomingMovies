//
//  SearchMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class SearchMoviesViewController: UIViewController, SegueHandler {
    
    private var viewModel: SearchMoviesViewModel = SearchMoviesViewModel()
    private var searchController: DefaultSearchController!
    private var searchOptionsContainerView: SearchOptionsTableViewController!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationBar()
        setupSearchController()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchController() {
        let searchResultController = viewModel.prepareSearchResultController()
        searchController = DefaultSearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchResultController.delegate = self
    }
    
    private func startSearch(_ resultController: SearchMoviesResultController, withSearchText searchText: String) {
        resultController.startSearch(withSearchText: searchText)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .movieList:
            guard let viewController = segue.destination as? MovieListViewController else { fatalError() }
            guard let viewModel = sender as? MovieListViewModel else { return }
            _ = viewController.view
            viewController.viewModel = viewModel
        case .movieDetail:
            guard let viewController = segue.destination as? MovieDetailViewController else { fatalError() }
            guard let viewModel = sender as? MovieDetailViewModel else { return }
            _ = viewController.view
            viewController.viewModel = viewModel
        case .searchOption:
            guard let viewController = segue.destination as? SearchOptionsTableViewController else { fatalError() }
            _ = viewController.view
            viewController.delegate = self
            viewController.viewModel = viewModel.buildSearchOptionsViewModel()
            searchOptionsContainerView = viewController
        }
    }

}

// MARK: - TabBarScrollable

extension SearchMoviesViewController: TabBarScrollable {
    
    func handleTabBarSelection() {
        searchOptionsContainerView.tableView.scrollToTop(animated: true)
    }
    
}

// MARK: - UISearchResultsUpdating

extension SearchMoviesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchResultsController = searchController.searchResultsController as? SearchMoviesResultController else {
            return
        }
        searchController.searchResultsController?.view.isHidden = false
        if let isEmpty = searchController.searchBar.text?.isEmpty,
            isEmpty {
            searchResultsController.resetSearch()
        }
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
            !searchText.isEmpty,
            let searchResultsController = searchController.searchResultsController as? SearchMoviesResultController else {
                return
        }
        startSearch(searchResultsController, withSearchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let searchResultsController = searchController.searchResultsController as? SearchMoviesResultController else {
            return
        }
        searchResultsController.resetSearch()
    }
    
}

// MARK: - SearchMoviesResultControllerDelegate

extension SearchMoviesViewController: SearchMoviesResultControllerDelegate {
    
    func searchMoviesResultController(_ searchMoviesResultController: SearchMoviesResultController, didSelectMovie movie: MovieDetailViewModel) {
        performSegue(withIdentifier: "MovieDetailSegue", sender: movie)
    }
    
    func searchMoviesResultController(_ searchMoviesResultController: SearchMoviesResultController, didSelectRecentSearch searchText: String) {
        searchController.searchBar.text = searchText
        guard let searchText = searchController.searchBar.text,
            !searchText.isEmpty,
            let searchResultsController = searchController.searchResultsController as? SearchMoviesResultController else {
                return
        }
        searchController.searchBar.endEditing(true)
        startSearch(searchResultsController, withSearchText: searchText)
    }
    
}

// MARK: - SearchOptionsTableViewControllerDelegate

extension SearchMoviesViewController: SearchOptionsTableViewControllerDelegate {
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectPopularMovies selected: Bool) {
        performSegue(withIdentifier: SegueIdentifier.movieList.rawValue, sender: viewModel.popularMoviesViewModel())
    }
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectTopRatedMovies selected: Bool) {
        performSegue(withIdentifier: SegueIdentifier.movieList.rawValue, sender: viewModel.topRatedMoviesViewModel())
    }
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectMovieGenre genreId: Int) {
        let viewModel = self.viewModel.moviesByGenreViewModel(genreId: genreId)
        performSegue(withIdentifier: SegueIdentifier.movieList.rawValue,
                     sender: viewModel)
    }
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectRecentlyVisitedMovie id: Int, title: String) {
        let viewModel = self.viewModel.recentlyVisitedMovieViewModel(id: id, title: title)
        performSegue(withIdentifier: SegueIdentifier.movieDetail.rawValue,
                     sender: viewModel)
    }
    
}

// MARK: - Segue Identifiers

extension SearchMoviesViewController {
    
    enum SegueIdentifier: String {
        case movieDetail = "MovieDetailSegue"
        case movieList = "MovieListSegue"
        case searchOption = "SearchOptionSegue"
    }
    
}

// MARK: - Constants

extension SearchMoviesViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("searchMoviesTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("searchMoviesTitle", comment: "")
        
        static let noRecentSearchText = "No recent searches to show."
        
    }
    
}

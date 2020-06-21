//
//  SearchMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class SearchMoviesViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var containerView: UIView!
    
    static var storyboardName: String = "SearchMovies"
    
    private var searchController: DefaultSearchController!
    private var searchOptionsContainerView: SearchOptionsTableViewController!
    
    var viewModel: SearchMoviesViewModel!
    weak var coordinator: SearchMoviesCoordinator?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationBar()
        setupContainerView()
        setupSearchController()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupContainerView() {
        guard let coordinator = coordinator else { return }
        searchOptionsContainerView = coordinator.embedSearchOptions(on: self, in: containerView)
        searchOptionsContainerView.delegate = self
    }
    
    private func setupSearchController() {
        guard let coordinator = coordinator else { return }
        
        searchController = coordinator.embedSearchController(with: self)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func startSearch(_ resultController: SearchMoviesResultController, withSearchText searchText: String) {
        resultController.startSearch(withSearchText: searchText)
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
        coordinator?.showPopularMovies()
    }
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectTopRatedMovies selected: Bool) {
        coordinator?.showTopRatedMovies()
    }
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectMovieGenreWithId genreId: Int, andGenreName genreName: String) {
        coordinator?.showMoviesByGenre(genreId, genreName: genreName)
    }
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectRecentlyVisitedMovie id: Int, title: String) {
        coordinator?.showDetail(for: id, and: title)
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

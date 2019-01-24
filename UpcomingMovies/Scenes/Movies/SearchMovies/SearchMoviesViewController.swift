//
//  SearchMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CoreData

class SearchMoviesViewController: UIViewController {
    
    private var viewModel: SearchMoviesViewModel = SearchMoviesViewModel()
    private var searchController: MovieSearchController!
    
    private var managedObjectContext: NSManagedObjectContext {
        guard let appDelegate = appDelegate else { fatalError() }
        return appDelegate.persistentContainer.viewContext
    }
    
    private lazy var customFooterView: CustomFooterView = {
        let footerView = CustomFooterView()
        footerView.message = Constants.noRecentSearchText
        footerView.frame = CustomFooterView.recommendedFrame
        return footerView
    }()
    
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
        let searchResultController = viewModel.prepareSearchResultController(managedObjectContext)
        searchController = MovieSearchController(searchResultsController: searchResultController)
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
        if let viewController = segue.destination as? MovieDetailViewController, let viewModel = sender as? MovieDetailViewModel {
            _ = viewController.view
            viewController.viewModel = viewModel
        } else if let viewController = segue.destination as? SearchOptionsTableViewController {
            _ = viewController.view
            viewController.delegate = self
            viewController.viewModel = viewModel.searchOptionsViewModel(managedObjectContext)
        } else if let viewController = segue.destination as? MovieListViewController, let viewModel = sender as? MovieListViewModel {
            viewController.viewModel = viewModel
        }
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
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController, didSelectPopularMovies selected: Bool) {
        performSegue(withIdentifier: "MovieListSegue", sender: viewModel.popularMoviesViewModel())
    }
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController, didSelectTopRatedMovies selected: Bool) {
        performSegue(withIdentifier: "MovieListSegue", sender: viewModel.topRatedMoviesViewModel())
    }
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController, didSelectMovieGenre genreId: Int) {
        performSegue(withIdentifier: "MovieListSegue", sender: viewModel.moviesByGenreViewModel(genreId: genreId))
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

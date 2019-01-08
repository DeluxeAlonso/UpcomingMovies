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
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SearchMoviesViewModel!
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
        self.viewModel = SearchMoviesViewModel(managedObjectContext: managedObjectContext)
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationBar()
        setupTableView()
        setupSearchController()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = viewModel.recentSearches.count > 0 ? UIView() : customFooterView
        tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        tableView.register(UINib(nibName: RecentSearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
    }
    
    private func setupSearchController() {
        let searchResultViewModel = SearchMoviesResultViewModel()
        let searchResultController = SearchMoviesResultController(viewModel: searchResultViewModel)
        searchController = MovieSearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchResultController.delegate = self
    }
    
    private func reloadRecentSearches() {
        tableView.tableFooterView = viewModel.recentSearches.count > 0 ? UIView() : customFooterView
        tableView.reloadData()
    }
    
    private func startSearch(_ resultController: SearchMoviesResultController, withSearchText searchText: String) {
        viewModel.saveSearchText(searchText)
        resultController.startSearch(withSearchText: searchText)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MovieDetailViewController, let viewModel = sender as? MovieDetailViewModel {
            _ = viewController.view
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

// MARK: - UITableViewDataSource

extension SearchMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchText = viewModel.recentSearches[indexPath.row].searchText
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        cell.viewModel = RecentSearchCellViewModel(searchText: searchText)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SearchMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchController.searchBar.text = viewModel.recentSearches[indexPath.row].searchText
        guard let searchText = searchController.searchBar.text,
            !searchText.isEmpty,
            let searchResultsController = searchController.searchResultsController as? SearchMoviesResultController else {
                return
        }
        searchController.searchBar.becomeFirstResponder()
        startSearch(searchResultsController, withSearchText: searchText)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = RecentSearchesHeaderView()
        return view
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
        viewModel.loadRecentSearches()
        reloadRecentSearches()
        searchResultsController.resetSearch()
    }
    
}

// MARK: - SearchMoviesResultControllerDelegate

extension SearchMoviesViewController: SearchMoviesResultControllerDelegate {
    
    func searchMoviesResultController(_ searchMoviesResultController: SearchMoviesResultController, didSelectMovie movie: MovieDetailViewModel) {
        performSegue(withIdentifier: "MovieDetailSegue", sender: movie)
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


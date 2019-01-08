//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController, Retryable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var loadingView: UIView!
    
    private var viewModel = UpcomingMoviesViewModel()
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    var errorView: ErrorPlaceholderView?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
        viewModel.getUpcomingMovies()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = 150
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.register(UINib(nibName: MovieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: UpcomingMoviesViewState) {
        switch state {
        case .loading, .paging:
            tableView.tableFooterView = loadingView
            hideErrorView()
        case .populated, .empty:
            tableView.tableFooterView = nil
            hideErrorView()
        case .error(let error):
            showErrorView(withErrorMessage: error.localizedDescription)
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        setupViewStateReactiveBehaviour()
    }
    
    private func setupViewStateReactiveBehaviour() {
        viewModel.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(withState: state)
            strongSelf.tableView.reloadData()
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MovieDetailViewController, let indexPath = sender as? IndexPath {
            _ = viewController.view
            viewController.viewModel = viewModel.buildDetailViewModel(atIndex: indexPath.row)
        }
    }
    
}

// MARK: - UITableViewDataSource

extension UpcomingMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as!
        MovieTableViewCell
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension UpcomingMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "MovieDetailSegue", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            TableViewCellAnimator.fadeAnimate(cell: cell)
        }
    }
    
}

// MARK - Retryable

extension UpcomingMoviesViewController {
    
    func showErrorView(withErrorMessage errorMessage: String?) {
        self.presentFullScreenErrorView(withErrorMessage: errorMessage)
        self.errorView?.retry = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.getUpcomingMovies()
        }
    }
    
}

// MARK: - UITableViewDataSourcePrefetching

extension UpcomingMoviesViewController: UITableViewDataSourcePrefetching {
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.movieCells.count - 1
    }
    
    private func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getUpcomingMovies()
        }
    }
    
}

// MARK: - Constants

extension UpcomingMoviesViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("upcomingMoviesTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("upcomingMoviesTitle", comment: "")
        
    }
    
}

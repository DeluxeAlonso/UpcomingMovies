//
//  MovieListViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, Retryable, SegueHandler {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var loadingView: UIView!
    
    var viewModel: MovieListViewModel = MovieListViewModel()
    
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    var errorView: ErrorPlaceholderView?
    
    // MARK: - Lifcycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupTableView()
        setupForceTouchSupport()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = 150
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.register(UINib(nibName: MovieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    private func setupForceTouchSupport() {
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
    }
    
    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: MovieListViewState) {
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
        title = viewModel.filter.title
        viewModel.getMovies()
        viewModel.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(withState: state)
            strongSelf.tableView.reloadData()
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .movieDetail:
            guard let viewController = segue.destination as? MovieDetailViewController else { fatalError() }
            guard let indexPath = sender as? IndexPath else { return }
            _ = viewController.view
            viewController.viewModel = viewModel.buildDetailViewModel(atIndex: indexPath.row)
        }
    }

}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    
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

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIdentifier.movieDetail.rawValue, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            TableViewCellAnimator.fadeAnimate(cell: cell)
        }
    }
    
}

// MARK: - Retryable

extension MovieListViewController {
    
    func showErrorView(withErrorMessage errorMessage: String?) {
        self.presentFullScreenErrorView(withErrorMessage: errorMessage)
        self.errorView?.retry = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.getMovies()
        }
    }
    
}

// MARK: - UITableViewDataSourcePrefetching

extension MovieListViewController: UITableViewDataSourcePrefetching {
    
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
            viewModel.getMovies()
        }
    }
    
}

extension MovieListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        _ = viewController.view
        viewController.viewModel = viewModel.buildDetailViewModel(atIndex: indexPath.row)
        viewController.preferredContentSize = CGSize(width: 0.0, height: 450)
        previewingContext.sourceRect = cell.frame
        return viewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: nil)
    }
    
}

// MARK: - Segue Identifiers

extension MovieListViewController {
    
    enum SegueIdentifier: String {
        case movieDetail = "MovieDetailSegue"
    }
    
}

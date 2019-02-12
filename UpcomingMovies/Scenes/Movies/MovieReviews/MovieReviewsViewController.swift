//
//  MovieReviewsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieReviewsViewController: UIViewController, Retryable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var loadingView: UIView!
    
    private lazy var customFooterView: CustomFooterView = {
        let footerView = CustomFooterView()
        footerView.frame = CustomFooterView.recommendedFrame
        return footerView
    }()
    
    var viewModel: MovieReviewsViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    private var dataSource: SimpleTableViewDataSource<MovieReviewCellViewModel>!
    private var prefetchDataSource: TableViewDataSourcePrefetching!
    
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    var errorView: ErrorPlaceholderView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(MovieReviewTableViewCell.self,
                           forCellReuseIdentifier: MovieReviewTableViewCell.identifier)
        tableView.register(UINib(nibName: MovieReviewTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: MovieReviewTableViewCell.identifier)
    }
    
    private func reloadTableView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleTableViewDataSource.make(for: viewModel.reviewCells)
        prefetchDataSource = TableViewDataSourcePrefetching(cellCount: viewModel.reviewCells.count,
                                                            prefetchHandler: { [weak self] in
                                                                self?.viewModel?.getMovieReviews()
        })
        tableView.dataSource = dataSource
        tableView.prefetchDataSource = prefetchDataSource
        tableView.reloadData()
    }
    
    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: MovieReviewsViewState) {
        switch state {
        case .loading:
            tableView.tableFooterView = loadingView
            hideErrorView()
        case .populated, .paging:
            tableView.tableFooterView = UIView()
            hideErrorView()
        case .empty:
            tableView.tableFooterView = customFooterView
            customFooterView.message = "There are no reviews to show right now."
            hideErrorView()
        case .error(let error):
            showErrorView(withErrorMessage: error.localizedDescription)
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        title = viewModel?.movieTitle
        viewModel?.getMovieReviews()
        
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(withState: state)
            strongSelf.reloadTableView()
        })
    }

}

// MARK: - Retryable

extension MovieReviewsViewController {
    
    func showErrorView(withErrorMessage errorMessage: String?) {
        self.presentFullScreenErrorView(withErrorMessage: errorMessage)
        self.errorView?.retry = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel?.getMovieReviews()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension MovieReviewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

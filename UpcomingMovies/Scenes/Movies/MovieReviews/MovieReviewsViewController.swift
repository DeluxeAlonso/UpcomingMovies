//
//  MovieReviewsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class MovieReviewsViewController: UIViewController, PlaceholderDisplayable, Loadable, SegueHandler {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MovieReviewsViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    private var dataSource: SimpleTableViewDataSource<MovieReviewCellViewModel>!
    private var prefetchDataSource: TableViewDataSourcePrefetching!
    private var scaleTransitioningDelegate: ScaleTransitioningDelegate!
    
    var loaderView: RadarView!
    
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
        tableView.registerNib(cellType: MovieReviewTableViewCell.self)
    }
    
    private func reloadTableView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleTableViewDataSource.make(for: viewModel.reviewCells)
        prefetchDataSource = TableViewDataSourcePrefetching(cellCount: viewModel.reviewCells.count,
                                                            needsPrefetch: viewModel.needsPrefetch,
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
    private func configureView(withState state: SimpleViewState<Review>) {
        switch state {
        case .populated, .paging, .initial:
            hideDisplayedPlaceholderView()
            tableView.tableFooterView = UIView()
        case .empty:
            presentEmptyView(with: "There are no reviews to show right now.")
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                                       errorHandler: { [weak self] in
                                        self?.viewModel?.refreshMovieReviews()
            })
        }
    }
    
    private func configureTransitioningDelegate(with view: UIView) {
        scaleTransitioningDelegate = ScaleTransitioningDelegate(viewToScale: view)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        title = viewModel?.movieTitle
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.configureView(withState: state)
                strongSelf.reloadTableView()
            }
        })
        viewModel?.startLoading.bind({[weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        })
        viewModel?.getMovieReviews()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .reviewDetail:
            guard let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.topViewController as? MovieReviewDetailViewController else {
                fatalError()
            }
            guard let indexPath = sender as? IndexPath else { return }
            _ = viewController.view
            navigationController.transitioningDelegate = scaleTransitioningDelegate
            viewController.viewModel = viewModel?.buildReviewDetailViewModel(at: indexPath.row)
        }
    }

}

// MARK: - UITableViewDelegate

extension MovieReviewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // We retrieve the cell which we are going to use for our scale transition
        guard let selectedCell = tableView.cellForRow(at: indexPath) else { return }
        configureTransitioningDelegate(with: selectedCell)
        performSegue(withIdentifier: SegueIdentifier.reviewDetail.rawValue, sender: indexPath)
    }
    
}

// MARK: - Segue Identifiers

extension MovieReviewsViewController {
    
    enum SegueIdentifier: String {
        case reviewDetail = "MovieReviewDetailSegue"
    }
    
}

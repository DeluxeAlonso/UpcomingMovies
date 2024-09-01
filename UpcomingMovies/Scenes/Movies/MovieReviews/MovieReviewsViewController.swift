//
//  MovieReviewsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieReviewsViewController: UIViewController, Storyboarded, PlaceholderDisplayable, LoadingDisplayable {

    @IBOutlet private weak var tableView: UITableView!

    static var storyboardName = "MovieDetail"

    private var dataSource: SimpleTableViewDataSource<MovieReviewCellViewModelProtocol>?
    private var prefetchDataSource: TableViewDataSourcePrefetching?
    private var scaleTransitioningDelegate: ScaleTransitioningDelegate?

    var viewModel: MovieReviewsViewModelProtocol?
    weak var coordinator: MovieReviewsCoordinatorProtocol?

    // MARK: - LoadingDisplayable

    let loaderView: LoadingView = RadarView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }

    // MARK: - Private

    private func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.registerNib(cellType: MovieReviewCell.self)
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
    private func configureView(withState state: MovieReviewsViewState) {
        switch state {
        case .populated, .paging, .initial:
            hideDisplayedPlaceholderView()
            tableView.tableFooterView = UIView()
        case .empty:
            presentEmptyView(with: viewModel?.emptyReviewResultsTitle)
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                             retryHandler: { [weak self] in
                                self?.viewModel?.refreshMovieReviews()
                             })
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        title = viewModel?.movieTitle
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let self = self else { return }
            self.configureView(withState: state)
            self.reloadTableView()
        }, on: .main)

        viewModel?.startLoading.bind({[weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        }, on: .main)

        viewModel?.getMovieReviews()
    }

}

// MARK: - UITableViewDelegate

extension MovieReviewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // We retrieve the cell which we are going to use for our scale transition
        guard let viewModel = viewModel else { return }
        guard let selectedCell = tableView.cellForRow(at: indexPath) else { return }
        coordinator?.showReviewDetail(for: viewModel.selectedReview(at: indexPath.row), transitionView: selectedCell)
    }

}

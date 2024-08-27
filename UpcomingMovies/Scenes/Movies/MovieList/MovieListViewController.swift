//
//  MovieListViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController, Storyboarded, PlaceholderDisplayable, LoadingDisplayable {

    @IBOutlet private weak var tableView: UITableView!

    private var dataSource: SimpleTableViewDataSource<MovieListCellViewModelProtocol>?
    private var prefetchDataSource: TableViewDataSourcePrefetching?
    private var displayedCellsIndexPaths = Set<IndexPath>()

    static var storyboardName: String = "MovieList"

    var viewModel: MovieListViewModelProtocol?
    weak var coordinator: MovieListCoordinatorProtocol?

    // MARK: - LoadingDisplayable

    let loaderView: LoadingView = RadarView()

    // MARK: - Lifcycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.getMovies()
    }

    // MARK: - Private

    private func setupUI() {
        setupTableView()
        setupRefreshControl()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.registerNib(cellType: MovieListCell.self)
    }

    private func setupRefreshControl() {
        tableView.refreshControl = DefaultRefreshControl(tintColor: ColorPalette.lightBlueColor,
                                                         backgroundColor: tableView.backgroundColor,
                                                         refreshHandler: { [weak self] in
                                                            self?.viewModel?.refreshMovies()
                                                         })
    }

    private func reloadTableView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleTableViewDataSource.make(for: viewModel.movieCells)
        prefetchDataSource = TableViewDataSourcePrefetching(cellCount: viewModel.movieCells.count,
                                                            needsPrefetch: viewModel.needsPrefetch,
                                                            prefetchHandler: { [weak self] in
                                                                self?.viewModel?.getMovies()
                                                            })
        tableView.dataSource = dataSource
        tableView.prefetchDataSource = prefetchDataSource
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing(with: 0.5)
    }

    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: MovieListViewState) {
        switch state {
        case .paging:
            hideDisplayedPlaceholderView()
            tableView.tableFooterView = LoadingFooterView()
        case .populated, .initial:
            hideDisplayedPlaceholderView()
            tableView.tableFooterView = UIView()
        case .empty:
            presentEmptyView(with: viewModel?.emptyMovieResultsTitle)
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                             retryHandler: { [weak self] in
                                self?.viewModel?.refreshMovies()
                             })
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        title = viewModel?.displayTitle
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let self = self else { return }
            self.configureView(withState: state)
            self.reloadTableView()
        }, on: .main)

        viewModel?.startLoading.bind({ [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        }, on: .main)
    }

}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        coordinator?.showMovieDetail(for: viewModel.selectedMovie(at: indexPath.row))
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            TableViewCellAnimator.fadeAnimate(cell: cell)
        }
    }

}

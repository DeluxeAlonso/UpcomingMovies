//
//  MovieVideosViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MovieVideosViewController: UIViewController, Storyboarded, PlaceholderDisplayable, LoadingDisplayable {

    @IBOutlet private weak var tableView: UITableView!

    static var storyboardName = "MovieDetail"

    private var dataSource: SimpleTableViewDataSource<MovieVideoCellViewModelProtocol>?
    private var displayedCellsIndexPaths = Set<IndexPath>()

    var viewModel: MovieVideosViewModelProtocol?
    weak var coordinator: MovieVideosCoordinatorProtocol?

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
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerNib(cellType: MovieVideoCell.self)
    }

    private func reloadTableView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleTableViewDataSource.make(for: viewModel.videoCells)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: MovieVideosViewState) {
        switch state {
        case .paging:
            hideDisplayedPlaceholderView()
            tableView.tableFooterView = LoadingFooterView()
        case .populated, .initial:
            hideDisplayedPlaceholderView()
            tableView.tableFooterView = UIView()
        case .empty:
            presentEmptyView(with: viewModel?.emptyVideoResultsTitle)
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                             retryHandler: { [weak self] in
                                self?.viewModel?.getMovieVideos(showLoader: false)
                             })
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        title = viewModel?.movieTitle
        viewModel?.viewState.bindAndFire({ [weak self] viewState in
            guard let self = self else { return }
            self.configureView(withState: viewState)
            self.reloadTableView()
        }, on: .main)

        viewModel?.startLoading.bind({ [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        }, on: .main)

        viewModel?.getMovieVideos(showLoader: true)
    }

}

// MARK: - UITableViewDelegate

extension MovieVideosViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let videoURL = viewModel?.videoURL(at: indexPath.row)
        openDeepLinkURL(videoURL)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            TableViewCellAnimator.fadeAnimate(cell: cell)
        }
    }

}

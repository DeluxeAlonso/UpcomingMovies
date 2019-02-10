//
//  MovieVideosViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import AVKit

class MovieVideosViewController: UIViewController, Retryable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var loadingView: UIView!
    
    private lazy var customFooterView: CustomFooterView = {
        let footerView = CustomFooterView()
        footerView.frame = CustomFooterView.recommendedFrame
        return footerView
    }()
    
    var viewModel: MovieVideosViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    private var dataSource: SimpleTableViewDataSource<MovieVideoCellViewModel>!
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    var errorView: ErrorPlaceholderView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieVideoTableViewCell.self, forCellReuseIdentifier: MovieVideoTableViewCell.identifier)
        tableView.register(UINib(nibName: MovieVideoTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: MovieVideoTableViewCell.identifier)
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
        case .loading:
            tableView.tableFooterView = loadingView
            hideErrorView()
        case .populated:
            tableView.tableFooterView = UIView()
            hideErrorView()
        case .empty:
            tableView.tableFooterView = customFooterView
            customFooterView.message = "There are no trailers to show right now."
            hideErrorView()
        case .error(let error):
            showErrorView(withErrorMessage: error.localizedDescription)
        }
    }

    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        title = viewModel?.movieTitle
        viewModel?.getMovieVideos()
        viewModel?.viewState.bindAndFire({ [weak self] viewState in
            guard let strongSelf = self else { return }
            strongSelf.configureView(withState: viewState)
            strongSelf.reloadTableView()
        })
    }

}

// MARK: - Retryable

extension MovieVideosViewController {
    
    func showErrorView(withErrorMessage errorMessage: String?) {
        self.presentFullScreenErrorView(withErrorMessage: errorMessage)
        self.errorView?.retry = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel?.getMovieVideos()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension MovieVideosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.playVideo(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            TableViewCellAnimator.fadeAnimate(cell: cell)
        }
    }
    
}

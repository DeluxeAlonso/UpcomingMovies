//
//  SavedMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout
import UpcomingMoviesDomain

class SavedMoviesViewController: UIViewController, Storyboarded, PlaceholderDisplayable, LoadingDisplayable {

    @IBOutlet private weak var collectionView: UICollectionView!

    static var storyboardName = "Account"

    private var dataSource: SimpleCollectionViewDataSource<SavedMovieCellViewModelProtocol>!
    private var prefetchDataSource: CollectionViewDataSourcePrefetching!

    var viewModel: SavedMoviesViewModelProtocol?
    weak var coordinator: SavedMoviesCoordinatorProtocol?

    // MARK: - LoadingDisplayable

    var loaderView: LoadingView = RadarView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let selectedViewController = tabBarController?.selectedViewController,
            selectedViewController == self || selectedViewController == navigationController else {
            return
        }
        updateCollectionViewLayout()
    }

    // MARK: - Private

    private func setupUI() {
        setupCollectionView()
        setupRefreshControl()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerNib(cellType: SavedMovieCollectionViewCell.self)
        setupCollectionViewLayout()
    }

    private func setupCollectionViewLayout() {
        let layout = CollectionViewSlantedLayout()
        layout.isFirstCellExcluded = true
        layout.isLastCellExcluded = true
        collectionView.collectionViewLayout = layout
    }

    private func updateCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            layout.itemSize = 225
        }
    }

    private func setupRefreshControl() {
        collectionView.refreshControl = DefaultRefreshControl(tintColor: ColorPalette.lightBlueColor,
                                                              backgroundColor: collectionView.backgroundColor,
                                                              refreshHandler: { [weak self] in
                                                                self?.viewModel?.refreshCollectionList()
        })
    }

    private func reloadCollectionView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleCollectionViewDataSource.make(for: viewModel.movieCells)

        prefetchDataSource = CollectionViewDataSourcePrefetching(cellCount: viewModel.movieCells.count,
                                                       needsPrefetch: viewModel.needsPrefetch,
                                                       prefetchHandler: { [weak self] in
                                                        self?.viewModel?.getCollectionList()
        })

        collectionView.dataSource = dataSource
        collectionView.prefetchDataSource = prefetchDataSource

        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }

    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: SimpleViewState<Movie>) {
        switch state {
        case .populated, .paging, .initial:
            hideDisplayedPlaceholderView()
            collectionView.backgroundView = UIView(frame: .zero)
        case .empty:
            presentEmptyView(with: "No movies to show")
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                                       retryHandler: { [weak self] in
                                        self?.viewModel?.refreshCollectionList()
            })
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        title = viewModel?.displayTitle
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.configureView(withState: state)
                self.updateCollectionViewLayout()
                self.reloadCollectionView()
            }
        })
        viewModel?.startLoading.bind({ [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        })
        viewModel?.getCollectionList()
    }

}

// MARK: - UICollectionViewDelegate

extension SavedMoviesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        coordinator?.showMovieDetail(for: viewModel.movie(at: indexPath.row))
    }

}

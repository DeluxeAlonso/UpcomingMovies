//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

final class UpcomingMoviesViewController: UIViewController, Storyboarded, LoadingDisplayable, PlaceholderDisplayable, TransitionableInitiator {

    @IBOutlet private weak var collectionView: UICollectionView!

    static var storyboardName: String = "UpcomingMovies"

    var viewModel: UpcomingMoviesViewModelProtocol?
    var layoutProvider: UpcomingMoviesLayoutProviderProtocol?
    weak var coordinator: UpcomingMoviesCoordinatorProtocol?

    private var dataSource: SimpleCollectionViewDataSource<UpcomingMovieCellViewModelProtocol>?
    private var prefetchDataSource: CollectionViewDataSourcePrefetching?
    private var displayedCellsIndexPaths = Set<IndexPath>()

    private var isAnimatingPresentation: Bool = false

    private lazy var toggleGridBarButtonItem = ToggleBarButtonItem()

    // MARK: - LoadingDisplayable

    let loaderView: LoadingView = RadarView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.getMovies()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let selectedViewController = tabBarController?.selectedViewController,
              selectedViewController == self || selectedViewController == navigationController else {
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.setupCollectionViewLayout()
        }, completion: nil)
    }

    // MARK: - Private

    private func setupUI() {
        title = LocalizedStrings.upcomingMoviesTabBarTitle()
        UIAccessibility.post(notification: .screenChanged, argument: self.navigationItem.title)

        setupNavigationBar()
        setupCollectionView()
        setupRefreshControl()
    }

    private func setupNavigationBar() {
        navigationItem.title = LocalizedStrings.upcomingMoviesTitle()

        toggleGridBarButtonItem.target = self
        toggleGridBarButtonItem.action = #selector(toggleGridAction)
        if let toggleBarButtonItemModel = viewModel?.getToggleBarButtonItemModel() {
            toggleGridBarButtonItem.update(with: toggleBarButtonItemModel)
        }
        navigationItem.leftBarButtonItem = toggleGridBarButtonItem
    }

    private func setupCollectionView() {
        collectionView.delegate = self

        collectionView.registerNib(cellType: UpcomingMoviePreviewCollectionViewCell.self)
        collectionView.registerNib(cellType: UpcomingMovieExpandedCollectionViewCell.self)

        setupCollectionViewLayout()
    }

    private func setupCollectionViewLayout() {
        guard let viewModel, let layoutProvider else { return }
        let presentationMode = viewModel.currentPresentationMode
        let collectionViewWidth = collectionView.frame.width

        collectionView.collectionViewLayout = layoutProvider.collectionViewLayout(for: presentationMode, and: collectionViewWidth)
    }

    private func setupRefreshControl() {
        collectionView.refreshControl = DefaultRefreshControl(tintColor: ColorPalette.lightBlueColor,
                                                              backgroundColor: collectionView.backgroundColor,
                                                              refreshHandler: { [weak self] in
            self?.viewModel?.refreshMovies()
        })
    }

    private func reloadCollectionView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleCollectionViewDataSource.make(for: viewModel.movieCells,
                                                            reuseIdentifier: viewModel.currentPresentationMode.cellIdentifier)

        prefetchDataSource = CollectionViewDataSourcePrefetching(cellCount: viewModel.movieCells.count,
                                                                 needsPrefetch: viewModel.needsPrefetch,
                                                                 prefetchHandler: { [weak self] in
            self?.viewModel?.getMovies()
        })

        collectionView.dataSource = dataSource
        collectionView.prefetchDataSource = prefetchDataSource

        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing(with: 0.5)
    }

    private func updateCollectionViewLayout(_ layout: UICollectionViewLayout) {
        collectionView.collectionViewLayout.invalidateLayout()

        reloadCollectionView()
        isAnimatingPresentation = true
        collectionView.setCollectionViewLayout(layout, animated: true) { completed in
            self.isAnimatingPresentation = !completed
        }
    }

    /**
     * Configures the view given the current state of the view.
     */
    private func configureView(withState state: UpcomingMoviesViewState) {
        switch state {
        case .populated, .paging, .initial:
            hideDisplayedPlaceholderView()
            collectionView.backgroundView = UIView(frame: .zero)
        case .empty:
            presentEmptyView(with: LocalizedStrings.emptyMovieResults())
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                             retryHandler: { [weak self] in
                                self?.viewModel?.refreshMovies()
                             })
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        viewModel?.viewState.bind({ [weak self] state in
            guard let self = self else { return }
            self.configureView(withState: state)
            self.reloadCollectionView()
        }, on: .main)

        viewModel?.startLoading.bind({ [weak self] startLoading in
            guard let self = self else { return }
            startLoading ? self.showLoader() : self.hideLoader()
        }, on: .main)

        viewModel?.didUpdatePresentationMode.bind({ [weak self] presentationMode in
            guard let self, let layoutProvider = self.layoutProvider else { return }
            let newCollectionViewLayout = layoutProvider.collectionViewLayout(for: presentationMode, and: self.collectionView.frame.width)
            self.updateCollectionViewLayout(newCollectionViewLayout)
        }, on: .main)
    }

    // MARK: - Actions

    @objc func toggleGridAction(_ sender: Any) {
        guard !isAnimatingPresentation else { return }

        toggleGridBarButtonItem.toggle()
        viewModel?.updatePresentationMode()
    }

}

// MARK: - TabBarScrollable

extension UpcomingMoviesViewController: TabBarSelectable {

    func handleTabBarSelection() {
        collectionView.scrollToTop(animated: true)
    }

}

// MARK: - UICollectionViewDelegate

extension UpcomingMoviesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellAttributes = collectionView.layoutAttributesForItem(at: indexPath),
              let cell = collectionView.cellForItem(at: indexPath) as? UpcomingMovieCollectionViewCellProtocol else {
            return
        }

        let imageToTransition = cell.posterImageView.image
        let selectedFrame = collectionView.convert(cellAttributes.frame,
                                                   to: collectionView.superview)

        let navigationConfiguration = UpcomingMoviesNavigationConfiguration(selectedFrame: selectedFrame,
                                                                            imageToTransition: imageToTransition,
                                                                            transitionOffset: view.safeAreaInsets.left)

        if let movieToShow = viewModel?.movie(for: indexPath.row) {
            coordinator?.showMovieDetail(for: movieToShow, with: navigationConfiguration)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            CollectionViewCellAnimator.fadeAnimate(cell: cell)
        }
    }

}

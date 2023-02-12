//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class UpcomingMoviesViewController: UIViewController, Storyboarded, LoadingDisplayable, PlaceholderDisplayable, TransitionableInitiator {

    @IBOutlet private weak var collectionView: UICollectionView!

    static var storyboardName: String = "UpcomingMovies"

    var viewModel: UpcomingMoviesViewModelProtocol!
    weak var coordinator: UpcomingMoviesCoordinatorProtocol?

    private var dataSource: SimpleCollectionViewDataSource<UpcomingMovieCellViewModelProtocol>!
    private var prefetchDataSource: CollectionViewDataSourcePrefetching!
    private var displayedCellsIndexPaths = Set<IndexPath>()

    private var previewLayout: VerticalFlowLayout!
    private var detailLayout: VerticalFlowLayout!

    private var isAnimatingPresentation: Bool = false

    private lazy var toggleGridBarButtonItem = ToggleBarButtonItem()

    // MARK: - LoadingDisplayable

    var loaderView: LoadingView = RadarView()

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
            let newWidth = self.collectionView.frame.width - Constants.detailCellOffset
            self.detailLayout.updatePreferredWidth(newWidth)
            self.collectionView.collectionViewLayout.invalidateLayout()
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

        toggleGridBarButtonItem.update(with: viewModel.getToggleBarButtonItemModel())
        toggleGridBarButtonItem.target = self
        toggleGridBarButtonItem.action = #selector(toggleGridAction)
        navigationItem.leftBarButtonItem = toggleGridBarButtonItem
    }

    private func setupCollectionView() {
        collectionView.delegate = self

        collectionView.registerNib(cellType: UpcomingMoviePreviewCollectionViewCell.self)
        collectionView.registerNib(cellType: UpcomingMovieExpandedCollectionViewCell.self)

        setupCollectionViewLayout()
    }

    private func setupCollectionViewLayout() {
        let detailLayoutWidth = collectionView.frame.width - Constants.detailCellOffset
        detailLayout = VerticalFlowLayout(preferredWidth: detailLayoutWidth,
                                          preferredHeight: Constants.detailCellHeight)

        let previewLayoutWidth = Constants.previewCellHeight / CGFloat(UIConstants.posterAspectRatio)
        previewLayout = VerticalFlowLayout(preferredWidth: previewLayoutWidth,
                                           preferredHeight: Constants.previewCellHeight,
                                           minColumns: Constants.previewLayoutMinColumns)

        collectionView.collectionViewLayout = viewModel.currentPresentationMode == .preview ? previewLayout : detailLayout
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
    }

    // MARK: - Actions

    @objc func toggleGridAction(_ sender: Any) {
        guard !isAnimatingPresentation else { return }

        toggleGridBarButtonItem.toggle()
        viewModel.updatePresentationMode()
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

        coordinator?.showMovieDetail(for: viewModel.movie(for: indexPath.row), with: navigationConfiguration)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            CollectionViewCellAnimator.fadeAnimate(cell: cell)
        }
    }

}

// MARK: - Constants

extension UpcomingMoviesViewController {

    struct Constants {

        static let previewCellHeight: CGFloat = 150.0

        static let detailCellHeight: CGFloat = 200.0
        static let detailCellOffset: CGFloat = 32.0

        static let previewLayoutMinColumns: Int = 3

    }

}

//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class UpcomingMoviesViewController: UIViewController, Storyboarded, PlaceholderDisplayable, Loadable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static var storyboardName: String = "UpcomingMovies"
    
    var viewModel: UpcomingMoviesViewModelProtocol!
    weak var coordinator: UpcomingMoviesCoordinatorProtocol?
    
    private var dataSource: SimpleCollectionViewDataSource<UpcomingMovieCellViewModelProtocol>!
    private var prefetchDataSource: CollectionViewDataSourcePrefetching!
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    private var previewLayout: VerticalFlowLayout!
    private var detailLayout: VerticalFlowLayout!
    
    var loaderView: RadarView!
    var toggleGridBarButtonItem: ToggleBarButtonItem!
    
    private var isAnimatingPresentation: Bool = false
    private var presentationMode: PresentationMode = .preview
    
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
        title = LocalizedStrings.upcomingMoviesTabBarTitle.localized
        UIAccessibility.post(notification: .screenChanged, argument: self.navigationItem.title)
        
        setupNavigationBar()
        setupCollectionView()
        setupRefreshControl()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = LocalizedStrings.upcomingMoviesTitle.localized
        
        toggleGridBarButtonItem = UpcomingMoviesViewFactory.makeGridBarButtonItem()
        toggleGridBarButtonItem.target = self
        toggleGridBarButtonItem.action = #selector(toggleGridAction)
        navigationItem.leftBarButtonItem = toggleGridBarButtonItem
    }

    private func setupCollectionView() {
        collectionView.delegate = self

        collectionView.registerNib(cellType: UpcomingMoviePreviewCollectionViewCell.self)
        collectionView.registerNib(cellType: UpcomingMovieExpandedCollectionViewCell.self)

        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
        let detailLayoutWidth = collectionView.frame.width - Constants.detailCellOffset
        detailLayout = VerticalFlowLayout(preferredWidth: detailLayoutWidth,
                                          preferredHeight: Constants.detailCellHeight)
        
        let previewLayoutWidth = Constants.previewCellHeight / CGFloat(UIConstants.posterAspectRatio)
        previewLayout = VerticalFlowLayout(preferredWidth: previewLayoutWidth,
                                           preferredHeight: Constants.previewCellHeight,
                                           minColumns: 3)
        
        collectionView.collectionViewLayout = presentationMode == .preview ? previewLayout : detailLayout
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
                                                         presentationMode: presentationMode)
        
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
    private func configureView(withState state: SimpleViewState<Movie>) {
        switch state {
        case .populated, .paging, .initial:
             hideDisplayedPlaceholderView()
            collectionView.backgroundView = UIView(frame: .zero)
        case .empty:
            presentEmptyView(with: LocalizedStrings.emptyMovieResults.localized)
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                                       errorHandler: { [weak self] in
                                        self?.viewModel?.refreshMovies()
            })
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel?.viewState.bind({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.configureView(withState: state)
                strongSelf.reloadCollectionView()
            }
        })
        viewModel?.startLoading.bind({ [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        })
    }
    
    // MARK: - Actions
    
    @objc func toggleGridAction(_ sender: Any) {
        guard !isAnimatingPresentation else { return }
        configureCollectionViewLayout()

        toggleGridBarButtonItem.toggle()
        switch presentationMode {
        case .preview:
            presentationMode = .detail
            updateCollectionViewLayout(detailLayout)
        case .detail:
            presentationMode = .preview
            updateCollectionViewLayout(previewLayout)
        }
    }
    
}

// MARK: - TabBarScrollable

extension UpcomingMoviesViewController: TabBarScrollable {
    
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
        
        let navigationConfiguration = NavigationConfiguration(selectedFrame: selectedFrame,
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

// MARK: - Presentation Modes

extension UpcomingMoviesViewController {
    
    enum PresentationMode {
        case preview
        case detail
        
        var cellIdentifier: String {
            switch self {
            case .preview:
                return UpcomingMoviePreviewCollectionViewCell.dequeuIdentifier
            case .detail:
                return UpcomingMovieExpandedCollectionViewCell.dequeuIdentifier
            }
        }
    }
    
}

// MARK: - Constants

extension UpcomingMoviesViewController {
    
    struct Constants {
        
        static let previewCellHeight: CGFloat = 150.0
        
        static let detailCellHeight: CGFloat = 200.0
        static let detailCellOffset: CGFloat = 32.0
        
    }
    
}

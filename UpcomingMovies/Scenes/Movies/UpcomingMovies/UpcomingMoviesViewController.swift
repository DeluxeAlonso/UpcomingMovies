//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController, Retryable, SegueHandler, LoaderDisplayable {

    @IBOutlet weak var toggleGridBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = UpcomingMoviesViewModel()
    
    private var dataSource: SimpleCollectionViewDataSource<UpcomingMovieCellViewModel>!
    private var prefetchDataSource: CollectionViewPrefetching!
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    private var previewLayout: VerticalFlowLayout!
    private var detailLayout: VerticalFlowLayout!
    
    private var selectedFrame: CGRect?
    private var imageToTransition: UIImage?
    private var transitionInteractor: TransitioningInteractor?
    
    var loaderView: RadarView!
    
    private var isAnimatingPresentation: Bool = false
    private var presentationMode: PresentationMode = .preview {
        didSet {
            if presentationMode == .preview {
                toggleGridBarButtonItem.image = #imageLiteral(resourceName: "List")
            } else {
                toggleGridBarButtonItem.image = #imageLiteral(resourceName: "Grid")
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
        viewModel.getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard tabBarController?.selectedIndex == MainTabBarController.Items.upcomingMovies.rawValue else {
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.detailLayout.itemSize.width = self.collectionView.frame.width - Constants.detailCellOffset
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
        
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationBar()
        setupCollectionView()
        setupRefreshControl()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerNib(cellType: UpcomingMoviePreviewCollectionViewCell.self)
        collectionView.registerNib(cellType: UpcomingMovieDetailCollectionViewCell.self)
        setupCollectionViewLayout()
    }
    
    private func setupCollectionViewLayout() {
        let detailLayoutWidth = Double(collectionView.frame.width - Constants.detailCellOffset)
        detailLayout = VerticalFlowLayout(width: detailLayoutWidth,
                                          height: Constants.detailCellHeight)
        
        let previewLayoutWidth = Constants.previewCellHeight / Movie.posterAspectRatio
        previewLayout = VerticalFlowLayout(width: previewLayoutWidth, height: Constants.previewCellHeight)
        
        collectionView.collectionViewLayout = presentationMode == .preview ? previewLayout : detailLayout
    }
    
    private func setupRefreshControl() {
        collectionView.refreshControl = DefaultRefreshControl(tintColor: ColorPalette.lightBlueColor,
                                              backgroundColor: collectionView.backgroundColor,
                                              refreshHandler: { [weak self] in
                                                self?.viewModel.refreshMovies()
        })
    }
    
    private func reloadCollectionView() {
        dataSource = SimpleCollectionViewDataSource.make(for: viewModel.movieCells,
                                                         presentationMode: presentationMode)
        
        prefetchDataSource = CollectionViewPrefetching(cellCount: viewModel.movieCells.count,
                                                       prefetchHandler: { [weak self] in
                                                        self?.viewModel.getMovies()
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
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: SimpleViewState<Movie>) {
        switch state {
        case .populated, .paging, .empty, .initial:
            collectionView.backgroundView = UIView(frame: .zero)
            hideErrorView()
        case .error(let error):
            presentFullScreenErrorView(withErrorMessage: error.localizedDescription,
                                       errorHandler: { [weak self] in
                                        self?.viewModel.getMovies()
            })
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.configureView(withState: state)
                strongSelf.reloadCollectionView()
            }
        })
        viewModel.startLoading = { [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .movieDetail:
            guard let viewController = segue.destination as? MovieDetailViewController else { fatalError() }
            guard let indexPath = sender as? IndexPath else { return }
            _ = viewController.view
            viewController.viewModel = viewModel.buildDetailViewModel(atIndex: indexPath.row)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func toggleGridAction(_ sender: Any) {
        guard !isAnimatingPresentation else { return }
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
        guard let cellAttributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let cell = collectionView.cellForItem(at: indexPath) as! UpcomingMovieCollectionViewCell
        imageToTransition = cell.posterImageView.image
        selectedFrame = collectionView.convert(cellAttributes.frame,
                                               to: collectionView.superview)
        viewModel.setSelectedMovie(at: indexPath.row)
        performSegue(withIdentifier: SegueIdentifier.movieDetail.rawValue, sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            CollectionViewCellAnimator.fadeAnimate(cell: cell)
        }
    }
    
}

// MARK: - UINavigationControllerDelegate

extension UpcomingMoviesViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = selectedFrame else { return nil }
        let transitionView = UIImageView(image: imageToTransition)
        transitionView.contentMode = .scaleAspectFit
        switch operation {
        case .push:
            transitionInteractor = TransitioningInteractor(attachTo: toVC)
            return TransitioningAnimator(isPresenting: true,
                                         originFrame: frame,
                                         transitionView: transitionView,
                                         verticalSafeAreaOffset: view.safeAreaInsets.left)
        case .pop, .none:
            return TransitioningAnimator(isPresenting: false,
                                         originFrame: frame,
                                         transitionView: transitionView)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
        guard let transitionInteractor = transitionInteractor else { return nil }
        return transitionInteractor.transitionInProgress ? transitionInteractor : nil
    }
    
}

// MARK: - Segue Identifiers

extension UpcomingMoviesViewController {
    
    enum SegueIdentifier: String {
        case movieDetail = "MovieDetailSegue"
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
                return UpcomingMovieDetailCollectionViewCell.dequeuIdentifier
            }
        }
    }
    
}

// MARK: - Constants

extension UpcomingMoviesViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("upcomingMoviesTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("upcomingMoviesTitle", comment: "")
        
        static let RefreshControlTitle = NSLocalizedString("refreshControlTitle", comment: "")
        
        static let previewCellHeight: Double = 150.0
        
        static let detailCellHeight: Double = 200.0
        static let detailCellOffset: CGFloat = 32.0
        
    }
    
}

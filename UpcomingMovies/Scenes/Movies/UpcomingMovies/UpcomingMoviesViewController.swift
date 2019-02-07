//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController, Retryable, SegueHandler {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var loadingView: UIView!
    
    private var viewModel = UpcomingMoviesViewModel()
    private var dataSource: UpcomingMoviesDataSource!
    
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    private var selectedFrame: CGRect?
    private var imageToTransition: UIImage?
    private var transitionInteractor: TransitioningInteractor?
    
    var errorView: ErrorPlaceholderView?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
        viewModel.getMovies()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationController?.delegate = self
        navigationItem.title = Constants.NavigationItemTitle
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.register(UpcomingMovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: UpcomingMovieCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: UpcomingMovieCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: UpcomingMovieCollectionViewCell.identifier)
    }
    
    private func reloadCollectionView() {
        dataSource = UpcomingMoviesDataSource(viewModel: viewModel,
                                              prefetchHandler: { [weak self] in
            self?.viewModel.getMovies()
        })
        collectionView.dataSource = dataSource
        collectionView.prefetchDataSource = dataSource
        collectionView.reloadData()
    }
    
    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: MoviesViewState) {
        switch state {
        case .loading:
            collectionView.backgroundView = loadingView
            hideErrorView()
        case .populated, .paging, .empty:
            collectionView.backgroundView = UIView(frame: .zero)
            hideErrorView()
        case .error(let error):
            showErrorView(withErrorMessage: error.localizedDescription)
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(withState: state)
            strongSelf.reloadCollectionView()
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .movieDetail:
            guard let viewController = segue.destination as? MovieDetailViewController else { fatalError() }
            guard let indexpath = sender as? IndexPath else { return }
            _ = viewController.view
            viewController.viewModel = viewModel.buildDetailViewModel(atIndex: indexpath.row)
        }
    }
    
}

// MARK: - TabBarScrollable

extension UpcomingMoviesViewController: TabBarScrollable {
    
    func handleTabBarSelection() {
        collectionView.scrollToTop(animated: true)
    }
    
}

// MARK: - Retryable

extension UpcomingMoviesViewController {
    
    func showErrorView(withErrorMessage errorMessage: String?) {
        self.presentFullScreenErrorView(withErrorMessage: errorMessage)
        self.errorView?.retry = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.getMovies()
        }
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

// MARK: - UICollectionViewDelegateFlowLayout

extension UpcomingMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let posterHeight: Double = Constants.cellHeight
        let posterWidth: Double = posterHeight / Movie.posterAspectRatio
        return CGSize(width: posterWidth, height: posterHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.cellMargin, left: Constants.cellMargin,
                            bottom: Constants.cellMargin, right: Constants.cellMargin)
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
                                                    transitionView: transitionView)
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

// MARK: - Constants

extension UpcomingMoviesViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("upcomingMoviesTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("upcomingMoviesTitle", comment: "")
        
        static let cellMargin: CGFloat = 16.0
        static let cellHeight: Double = 150.0
        
    }
    
}

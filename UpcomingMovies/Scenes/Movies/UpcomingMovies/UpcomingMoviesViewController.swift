//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController, Retryable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var loadingView: UIView!
    
    private var viewModel = UpcomingMoviesViewModel()
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    var errorView: ErrorPlaceholderView?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
        viewModel.getUpcomingMovies()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(UpcomingMovieCollectionViewCell.self, forCellWithReuseIdentifier: UpcomingMovieCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: UpcomingMovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: UpcomingMovieCollectionViewCell.identifier)
    }
    
    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: UpcomingMoviesViewState) {
        switch state {
        case .loading:
            collectionView.backgroundView = loadingView
            hideErrorView()
        case .populated, .paging, .empty:
            collectionView.backgroundView = UIView(frame: .zero)//nil
            hideErrorView()
        case .error(let error):
            showErrorView(withErrorMessage: error.localizedDescription)
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        setupViewStateReactiveBehaviour()
    }
    
    private func setupViewStateReactiveBehaviour() {
        viewModel.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(withState: state)
            strongSelf.collectionView.reloadData()
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MovieDetailViewController, let indexPath = sender as? IndexPath {
            _ = viewController.view
            viewController.viewModel = viewModel.buildDetailViewModel(atIndex: indexPath.row)
        }
    }
    
}

// MARK - Retryable

extension UpcomingMoviesViewController {
    
    func showErrorView(withErrorMessage errorMessage: String?) {
        self.presentFullScreenErrorView(withErrorMessage: errorMessage)
        self.errorView?.retry = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.getUpcomingMovies()
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension UpcomingMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieCollectionViewCell.identifier, for: indexPath) as! UpcomingMovieCollectionViewCell
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension UpcomingMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MovieDetailSegue", sender: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let posterHeight: Double = Constants.cellHeight
        let posterWidth: Double = posterHeight / Movie.posterAspectRatio
        return CGSize(width: posterWidth, height: posterHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.cellMargin, left: Constants.cellMargin, bottom: Constants.cellMargin, right: Constants.cellMargin)
    }
    
}

// MARK: - UICollectionViewDataSourcePrefetching

extension UpcomingMoviesViewController: UICollectionViewDataSourcePrefetching {
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.movieCells.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getUpcomingMovies()
        }
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

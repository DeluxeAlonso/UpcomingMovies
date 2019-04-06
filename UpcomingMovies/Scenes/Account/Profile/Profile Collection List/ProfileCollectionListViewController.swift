//
//  ProfileCollectionListViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

class ProfileCollectionListViewController: UIViewController, Retryable, SegueHandler, LoaderDisplayable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ProfileCollectionListViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    private var dataSource: SimpleCollectionViewDataSource<FavoriteMovieCellViewModel>!
    
    var loaderView: RadarView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard tabBarController?.selectedIndex == MainTabBarController.Items.favoriteMovies.rawValue else {
            return
        }
        updateCollectionViewLayout()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationBar()
        setupCollectionView()
        reloadCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerNib(cellType: FavoriteMovieCollectionViewCell.self)
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
    
    private func reloadCollectionView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleCollectionViewDataSource.make(for: viewModel.movieCells)
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: SimpleViewState<Movie>) {
        switch state {
        case .populated, .paging, .initial, .empty:
            collectionView.backgroundView = UIView(frame: .zero)
            hideErrorView()
        case .error(let error):
            presentFullScreenErrorView(withErrorMessage: error.localizedDescription,
                                       errorHandler: { [weak self] in
                                        self?.viewModel?.getCollectionList()
            })
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        reloadCollectionView()
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.configureView(withState: state)
                strongSelf.updateCollectionViewLayout()
                strongSelf.reloadCollectionView()
            }
        })
        viewModel?.startLoading = { [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        }
        viewModel?.getCollectionList()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.delegate = nil
        switch segueIdentifier(for: segue) {
        case .movieDetail:
            guard let viewController = segue.destination as? MovieDetailViewController,
                let index = sender as? Int else { fatalError() }
            _ = viewController.view
            viewController.viewModel = viewModel?.buildDetailViewModel(atIndex: index)
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension ProfileCollectionListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.movieDetail.rawValue,
                     sender: indexPath.row)
    }
    
}

// MARK: - Segue Identifiers

extension ProfileCollectionListViewController {
    
    enum SegueIdentifier: String {
        case movieDetail = "MovieDetailSegue"
    }
    
}

// MARK: - Constants

extension ProfileCollectionListViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("favoritesTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("favoritesTitle", comment: "")
        
    }
    
}

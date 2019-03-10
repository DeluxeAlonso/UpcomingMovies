//
//  FavoriteMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

class FavoriteMoviesViewController: UIViewController, SegueHandler {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = FavoriteMoviesViewModel()
    
    private var dataSource: SimpleCollectionViewDataSource<FavoriteMovieCellViewModel>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard tabBarController?.selectedIndex == MainTabBarController.Items.favoriteMovies.rawValue else {
            return
        }
        updateCollectionViewLayout()
    }
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationItem()
        setupCollectionView()
        reloadCollectionView()
    }
    
    private func setupNavigationItem() {
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
        dataSource = SimpleCollectionViewDataSource.make(for: viewModel.favoriteMovieCells)
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.updateFavorites = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.updateCollectionViewLayout()
            strongSelf.reloadCollectionView()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.delegate = nil
        switch segueIdentifier(for: segue) {
        case .movieDetail:
            guard let viewController = segue.destination as? MovieDetailViewController,
                let index = sender as? Int else { fatalError() }
            _ = viewController.view
            viewController.viewModel = viewModel.buildDetailViewModel(atIndex: index)
        }
    }
    
}

extension FavoriteMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.movieDetail.rawValue,
                     sender: indexPath.row)
    }
    
}

// MARK: - Segue Identifiers

extension FavoriteMoviesViewController {
    
    enum SegueIdentifier: String {
        case movieDetail = "MovieDetailSegue"
    }
    
}

// MARK: - Constants

extension FavoriteMoviesViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("favoritesTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("favoritesTitle", comment: "")
        
    }
    
}

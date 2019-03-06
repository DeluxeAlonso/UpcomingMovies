//
//  FavoriteMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

class FavoriteMoviesViewController: UIViewController {
    
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
    
}

extension FavoriteMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("Did select item at indexPath: [\(indexPath.section)][\(indexPath.row)]")
    }
    
}

// MARK: - Constants

extension FavoriteMoviesViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("favoritesTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("favoritesTitle", comment: "")
        
    }
    
}

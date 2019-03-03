//
//  FavoriteMoviesCollectionViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class FavoriteMoviesCollectionViewController: UICollectionViewController {
    
    var viewModel: FavoriteMoviesViewModel!
    
    private var dataSource: SimpleCollectionViewDataSource<FavoriteMovieCellViewModel>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
        setupBindables()
    }
    
    // MARK: - Private
    
    private func setupViewModel() {
        viewModel = FavoriteMoviesViewModel(managedObjectContext: managedObjectContext)
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
        collectionView.registerNib(cellType: FavoriteMovieCollectionViewCell.self)
        collectionView.decelerationRate = .fast
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
            strongSelf.reloadCollectionView()
        }
    }
    
}

// MARK: - Constants

extension FavoriteMoviesCollectionViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("favoritesTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("favoritesTitle", comment: "")
        
    }
    
}

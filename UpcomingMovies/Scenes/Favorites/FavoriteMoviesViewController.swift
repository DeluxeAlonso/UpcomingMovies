//
//  FavoriteMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        collectionView.delegate = self
        collectionView.decelerationRate = .fast
        collectionView.registerNib(cellType: FavoriteMovieCollectionViewCell.self)
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

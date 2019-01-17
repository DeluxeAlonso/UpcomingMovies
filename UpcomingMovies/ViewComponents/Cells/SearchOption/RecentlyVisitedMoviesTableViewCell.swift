//
//  RecentlyVisitedMoviesTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/16/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class RecentlyVisitedMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

// MARK: - UICollectionViewDataSource

extension RecentlyVisitedMoviesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell(frame: .zero)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension RecentlyVisitedMoviesTableViewCell: UICollectionViewDelegate {
    
}

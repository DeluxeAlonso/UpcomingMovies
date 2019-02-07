//
//  UpcomingMoviesDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    private let viewModel: UpcomingMoviesViewModel
    private let prefetchHandler: (() -> Void)?
    
    init(viewModel: UpcomingMoviesViewModel, prefetchHandler: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.prefetchHandler = prefetchHandler
    }
    
    // MARK: - Data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieCollectionViewCell.identifier,
                                                      for: indexPath) as! UpcomingMovieCollectionViewCell
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }
    
    // MARK: - Prefetching
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.movieCells.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let prefetchHandler = prefetchHandler else { return }
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }

}

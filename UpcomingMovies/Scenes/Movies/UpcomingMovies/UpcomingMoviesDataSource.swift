//
//  UpcomingMoviesDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviesDataSource: NSObject, UICollectionViewDataSource {
    
    private let viewModel: UpcomingMoviesViewModel
    
    init(viewModel: UpcomingMoviesViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieCollectionViewCell.identifier,
                                                      for: indexPath) as! UpcomingMovieCollectionViewCell
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }

}

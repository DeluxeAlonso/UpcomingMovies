//
//  UpcomingMoviePreviewCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviePreviewCollectionViewCell: UICollectionViewCell, UpcomingMovieCollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel: UpcomingMovieCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        posterImageView.setImage(with: viewModel.posterURL)
    }
    
}

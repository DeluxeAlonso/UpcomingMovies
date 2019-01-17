//
//  VisitedMovieCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

class VisitedMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VisitedMovieCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel: VisitedMovieCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: viewModel.fullPosterPath)
    }
    
}

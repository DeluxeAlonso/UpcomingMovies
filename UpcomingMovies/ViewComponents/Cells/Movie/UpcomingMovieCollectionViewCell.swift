//
//  UpcomingMovieCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

class UpcomingMovieCollectionViewCell: UICollectionViewCell, Animatable {
    
    static let identifier = "UpcomingMovieCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel: UpcomingMovieCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
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

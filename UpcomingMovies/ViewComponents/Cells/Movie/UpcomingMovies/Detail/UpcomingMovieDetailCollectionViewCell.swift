//
//  UpcomingMovieDetailCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class UpcomingMovieDetailCollectionViewCell: UICollectionViewCell, UpcomingMovieCollectionViewCell {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel: UpcomingMovieCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backdropImageView.image = nil
        titleLabel.text = nil
        releaseDateLabel.text = nil
        posterImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        titleLabel.font = FontHelper.bold(withSize: 21.0)
        releaseDateLabel.font = FontHelper.regular(withSize: 17.0)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        
        backdropImageView.setImage(with: viewModel.backdropURL)
        posterImageView.setImage(with: viewModel.posterURL)
    }
    
}

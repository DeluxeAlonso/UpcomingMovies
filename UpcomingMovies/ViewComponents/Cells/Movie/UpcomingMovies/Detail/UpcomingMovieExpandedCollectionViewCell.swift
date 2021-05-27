//
//  UpcomingMovieExpandedCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class UpcomingMovieExpandedCollectionViewCell: UICollectionViewCell, UpcomingMovieCollectionViewCellProtocol {
    
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    
    var viewModel: UpcomingMovieCellViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backdropImageView.cancelImageDownload()
        posterImageView.cancelImageDownload()
        backdropImageView.image = nil
        posterImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        isAccessibilityElement = true
        
        titleLabel.font = FontHelper.bold(withSize: 21.0)
        releaseDateLabel.font = FontHelper.regular(withSize: 17.0)
    }

    // MARK: - Reactive Behavior
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        accessibilityLabel = viewModel.title
        
        releaseDateLabel.text = viewModel.releaseDate
        
        backdropImageView.setImage(with: viewModel.backdropURL)
        posterImageView.setImage(with: viewModel.posterURL)
    }
    
}

//
//  UpcomingMoviePreviewCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviePreviewCollectionViewCell: UICollectionViewCell, UpcomingMovieCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel: UpcomingMovieCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        posterImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        titleLabel.textColor = ColorPalette.whiteColor
        titleLabel.numberOfLines = 0
        titleLabel.font = FontHelper.semiBold(withSize: 18.0)
        titleLabel.text = ""
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        if let posterURL = viewModel.posterURL {
            posterImageView.setImage(with: posterURL)
        } else {
            posterImageView.backgroundColor = .darkGray
            titleLabel.text = viewModel.title
        }
    }
    
}

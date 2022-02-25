//
//  UpcomingMoviePreviewCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class UpcomingMoviePreviewCollectionViewCell: UICollectionViewCell, UpcomingMovieCollectionViewCellProtocol {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var posterImageView: UIImageView!

    var viewModel: UpcomingMovieCellViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.cancelImageDownload()
        posterImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        isAccessibilityElement = true

        titleLabel.textColor = ColorPalette.whiteColor
        titleLabel.numberOfLines = 0
        titleLabel.font = FontHelper.bodySemiBold
        titleLabel.adjustsFontForContentSizeCategory = true
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        accessibilityLabel = viewModel.title
        if let posterURL = viewModel.posterURL {
            posterImageView.setImage(with: posterURL)
            titleLabel.text = nil
        } else {
            posterImageView.backgroundColor = .darkGray
            titleLabel.text = viewModel.title
        }
    }

}

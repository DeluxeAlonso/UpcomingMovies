//
//  MovieCreditCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieCreditCell: UICollectionViewCell {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    var viewModel: MovieCreditCellViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    override var isSelected: Bool {
        didSet {
            guard oldValue != isSelected else { return }
            if isSelected && !profileImageView.isEmpty {
                overlayView.fadeOut(Constants.fadeAnimationDuration)
            } else {
                overlayView.fadeIn(Constants.fadeAnimationDuration, to: 0.6)
            }
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.cancelImageDownload()
        profileImageView.image = nil
    }

    // MARK: - Private

    private func setupUI() {
        isAccessibilityElement = true

        nameLabel.font = FontHelper.subheadBold
        nameLabel.textColor = .white
        nameLabel.adjustsFontForContentSizeCategory = true

        subtitleLabel.font = FontHelper.footnote
        subtitleLabel.textColor = .white
        subtitleLabel.adjustsFontForContentSizeCategory = true
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        guard let viewModel = viewModel else { return }

        let creditLabelFormat = LocalizedStrings.movieCreditAccessibility()
        accessibilityLabel = String(format: creditLabelFormat, viewModel.name, viewModel.role)

        profileImageView.setImage(with: viewModel.profileURL)
        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.role
    }

}

struct Constants {
    static let fadeAnimationDuration: Double = 0.25
}

//
//  CustomListDetailHeaderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CustomListDetailHeaderView: UIView, NibLoadable {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var posterImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var posterImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    var initialHeightConstraintConstant: CGFloat!
    var initialTopContstraintConstant: CGFloat!

    var viewModel: CustomListDetailHeaderViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        initialHeightConstraintConstant = posterImageViewHeightConstraint.constant
        initialTopContstraintConstant = posterImageViewTopConstraint.constant
    }

    // MARK: - Private

    private func setupUI() {
        setupLabels()
        setupImageViews()
    }

    private func setupLabels() {
        nameLabel.font = FontHelper.body
        nameLabel.textColor = ColorPalette.darkBlueColor
        nameLabel.adjustsFontForContentSizeCategory = true

        descriptionLabel.font = FontHelper.calloutLight
        descriptionLabel.textColor = ColorPalette.darkBlueColor
        descriptionLabel.adjustsFontForContentSizeCategory = true
    }

    private func setupImageViews() {
        posterImageView.addOverlay()
    }

    // MARK: - Internal

    func setHeaderOffset(_ offset: CGFloat) {
        posterImageViewTopConstraint.constant = initialTopContstraintConstant - offset
    }

    func setPosterHeight(_ height: CGFloat) {
        posterImageViewHeightConstraint.constant = height
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        nameLabel.text = viewModel?.name
        if let description = viewModel?.description {
            descriptionLabel.text = description
        } else {
            descriptionView.isHidden = true
        }

        if let posterURL = viewModel?.posterURL {
            posterImageView.contentMode = .scaleAspectFill
            posterImageView.setImage(with: posterURL)
        } else {
            posterImageView.contentMode = .center
            posterImageView.image = #imageLiteral(resourceName: "PosterPlaceholder")
        }
    }

}

//
//  CustomListDetailSectionView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class CustomListDetailSectionView: UIView, NibLoadable {

    @IBOutlet private weak var movieCountValueLabel: UILabel!
    @IBOutlet private weak var ratingValueLabel: UILabel!
    @IBOutlet private weak var runtimeValueLabel: UILabel!

    @IBOutlet var titleLabels: [UILabel]!

    var viewModel: CustomListDetailSectionViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        movieCountValueLabel.textColor = ColorPalette.whiteColor
        movieCountValueLabel.font = FontHelper.body
        movieCountValueLabel.adjustsFontForContentSizeCategory = true

        ratingValueLabel.textColor = ColorPalette.whiteColor
        ratingValueLabel.font = FontHelper.body
        ratingValueLabel.adjustsFontForContentSizeCategory = true

        runtimeValueLabel.textColor = ColorPalette.whiteColor
        runtimeValueLabel.font = FontHelper.body
        runtimeValueLabel.adjustsFontForContentSizeCategory = true

        titleLabels.forEach {
            $0.textColor = ColorPalette.whiteColor
            $0.font = FontHelper.caption1Light
            $0.adjustsFontForContentSizeCategory = true
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        movieCountValueLabel.text = viewModel?.movieCountText
        ratingValueLabel.text = viewModel?.ratingText
        runtimeValueLabel.text = viewModel?.runtimeText
    }

}

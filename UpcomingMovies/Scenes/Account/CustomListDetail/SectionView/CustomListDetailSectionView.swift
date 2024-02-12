//
//  CustomListDetailSectionView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class CustomListDetailSectionView: UIView, NibLoadable {

    @IBOutlet private weak var movieCountTitleLabel: UILabel!
    @IBOutlet private weak var movieCountValueLabel: UILabel!
    @IBOutlet private weak var ratingTitleLabel: UILabel!
    @IBOutlet private weak var ratingValueLabel: UILabel!
    @IBOutlet private weak var runtimeTitleLabel: UILabel!
    @IBOutlet private weak var runtimeValueLabel: UILabel!
    @IBOutlet private weak var revenueTitleLabel: UILabel!
    @IBOutlet private weak var revenueValueLabel: UILabel!

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
        [movieCountValueLabel, ratingValueLabel, runtimeValueLabel, revenueValueLabel].forEach {
            $0.textColor = ColorPalette.whiteColor
            $0.font = FontHelper.body
            $0.adjustsFontForContentSizeCategory = true
        }

        [movieCountTitleLabel, ratingTitleLabel, runtimeTitleLabel, revenueTitleLabel].forEach {
            $0.textColor = ColorPalette.whiteColor
            $0.font = FontHelper.caption1Light
            $0.adjustsFontForContentSizeCategory = true
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        movieCountTitleLabel.text = LocalizedStrings.customListDetailSectionMovieCountTitle()
        movieCountValueLabel.text = viewModel?.movieCountText
        ratingTitleLabel.text = LocalizedStrings.customListDetailSectionRatingTitle()
        ratingValueLabel.text = viewModel?.ratingText
        runtimeTitleLabel.text = LocalizedStrings.customListDetailSectionRuntimeTitle()
        runtimeValueLabel.text = viewModel?.runtimeText
        revenueTitleLabel.text = LocalizedStrings.customListDetailSectionRevenueTitle()
        revenueValueLabel.text = viewModel?.revenueText
    }

}

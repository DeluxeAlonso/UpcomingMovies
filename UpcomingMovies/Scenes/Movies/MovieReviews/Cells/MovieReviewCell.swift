//
//  MovieReviewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieReviewCell: UITableViewCell {

    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    var viewModel: MovieReviewCellViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        setupLabels()
    }

    private func setupLabels() {
        authorNameLabel.font = FontHelper.calloutSemiBold
        authorNameLabel.adjustsFontForContentSizeCategory = true
        contentLabel.font = FontHelper.subheadLight
        contentLabel.adjustsFontForContentSizeCategory = true
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        authorNameLabel.text = viewModel?.authorName
        contentLabel.text = viewModel?.content
    }

}

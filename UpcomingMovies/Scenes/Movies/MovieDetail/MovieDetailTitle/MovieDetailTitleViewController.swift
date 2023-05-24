//
//  MovieDetailTitleViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 24/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

final class MovieDetailTitleViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var titleContentStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var voteAverageView: VoteAverageView!

    static var storyboardName: String = "MovieDetail"

    var viewModel: MovieDetailTitleViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func update(with viewModel: MovieDetailTitleViewModelProtocol) {
        self.viewModel = viewModel
        configureUI()
    }

    private func setupUI() {
        titleLabel.font = FontHelper.headline
        titleLabel.adjustsFontForContentSizeCategory = true

        subtitleLabel.font = FontHelper.subheadLight
        subtitleLabel.adjustsFontForContentSizeCategory = true

        genresLabel.font = FontHelper.subheadLight
        genresLabel.adjustsFontForContentSizeCategory = true
    }

    private func configureUI() {
        titleLabel.text = viewModel?.title
        titleLabel.text = viewModel?.title
        if FeatureFlags.shared.showRedesignedMovieDetailScreen {
            if !titleContentStackView.contains(subtitleLabel) {
                titleContentStackView.addArrangedSubview(subtitleLabel)
            }
            subtitleLabel.text = viewModel?.subtitle
            subtitleLabel.isHidden = false
        } else {
            if titleContentStackView.contains(subtitleLabel) {
                titleContentStackView.removeArrangedSubview(subtitleLabel)
                subtitleLabel.isHidden = true
            }
        }

        voteAverageView.voteValue = viewModel?.voteAverage
    }

}

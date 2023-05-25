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
        setupBindables()
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

    private func setupBindables() {
        viewModel?.showGenresNames.bindAndFire({ [weak self] genresNames in
            guard let self else { return }
            guard let genresNames else {
                if self.titleContentStackView.contains(self.genresLabel) {
                    self.titleContentStackView.removeArrangedSubview(self.genresLabel)
                    self.genresLabel.isHidden = true
                }
                return
            }
            if !self.titleContentStackView.contains(self.genresLabel) {
                self.titleContentStackView.addArrangedSubview(self.genresLabel)
            }
            self.genresLabel.text = genresNames
            self.genresLabel.isHidden = false
        }, on: .main)
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

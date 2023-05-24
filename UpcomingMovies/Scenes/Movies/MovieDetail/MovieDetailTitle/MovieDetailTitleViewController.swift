//
//  MovieDetailTitleViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 24/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

class MovieDetailTitleViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var titleContentStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var voteAverageView: VoteAverageView!

    static var storyboardName: String = "MovieDetail"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        titleLabel.font = FontHelper.headline
        titleLabel.adjustsFontForContentSizeCategory = true

        subtitleLabel.font = FontHelper.subheadLight
        subtitleLabel.adjustsFontForContentSizeCategory = true

        genresLabel.font = FontHelper.subheadLight
        genresLabel.adjustsFontForContentSizeCategory = true
    }

}

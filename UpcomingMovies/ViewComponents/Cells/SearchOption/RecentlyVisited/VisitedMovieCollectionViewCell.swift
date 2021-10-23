//
//  VisitedMovieCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class VisitedMovieCollectionViewCell: UICollectionViewCell, Animatable {

    @IBOutlet private weak var posterImageView: UIImageView!

    var viewModel: VisitedMovieCellViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    var settings: AnimatableSettings {
        var settings = AnimatableSettings()
        settings.transform = .init(scaleX: 0.90, y: 0.90)
        settings.duration = 0.3
        settings.springDamping = 1.0
        settings.springVelocity = 0.5
        return settings
    }

    // MARK: - Lifecycle

    override var isHighlighted: Bool {
        didSet {
            highlight(isHighlighted)
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        posterImageView.setImage(with: viewModel.posterURL)
    }

}

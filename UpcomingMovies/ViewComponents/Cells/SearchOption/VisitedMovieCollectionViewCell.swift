//
//  VisitedMovieCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

class VisitedMovieCollectionViewCell: UICollectionViewCell, Animatable {
    
    static let identifier = "VisitedMovieCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel: VisitedMovieCellViewModel? {
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
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: viewModel.fullPosterPath)
    }
    
}

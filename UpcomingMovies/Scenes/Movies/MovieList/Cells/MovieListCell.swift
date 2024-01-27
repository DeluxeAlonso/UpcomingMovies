//
//  MovieListCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

final class MovieListCell: UITableViewCell {

    @IBOutlet private weak var movieContainerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!

    @IBOutlet private weak var genreTitleLabel: UILabel!
    @IBOutlet private weak var genreValueLabel: UILabel!

    @IBOutlet private weak var releaseDateTitleLabel: UILabel!
    @IBOutlet private weak var releaseDateValueLabel: UILabel!

    @IBOutlet private weak var voteAverageView: VoteAverageView!

    var viewModel: MovieListCellViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.shouldRasterize = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.cancelImageDownload()
        posterImageView.image = nil
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        movieNameLabel.text = viewModel.name
        genreTitleLabel.text = LocalizedStrings.movieListCellGenreTitle()
        genreValueLabel.text = viewModel.genreName
        releaseDateTitleLabel.text = LocalizedStrings.movieListCellReleaseDateTitle()
        releaseDateValueLabel.text = viewModel.releaseDate
        posterImageView.setImage(with: viewModel.posterURL)
        voteAverageView.voteValue = viewModel.voteAverage
    }

}

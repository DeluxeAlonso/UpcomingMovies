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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
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
        nameLabel.text = viewModel.name
        genreLabel.text = viewModel.genreName
        releaseDateLabel.text = viewModel.releaseDate
        posterImageView.setImage(with: viewModel.posterURL)
        voteAverageView.voteValue = viewModel.voteAverage
    }

}

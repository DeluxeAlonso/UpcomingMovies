//
//  MovieVideoTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

class MovieVideoTableViewCell: UITableViewCell {
    
    static let identifier = "MovieVideoCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    
    var viewModel: MovieVideoCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        previewImageView.kf.indicatorType = .activity
        previewImageView.kf.setImage(with: viewModel.thumbnailURL)
    }

}

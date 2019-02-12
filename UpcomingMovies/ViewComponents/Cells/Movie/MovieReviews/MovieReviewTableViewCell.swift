//
//  MovieReviewTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieReviewTableViewCell: UITableViewCell {
    
    static let identifier = "MovieReviewCell"
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var viewModel: MovieReviewCellViewModel? {
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
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        authorNameLabel.text = viewModel?.authorName
        contentLabel.text = viewModel?.content
    }

}

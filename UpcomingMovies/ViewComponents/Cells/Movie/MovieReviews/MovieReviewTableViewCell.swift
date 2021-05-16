//
//  MovieReviewTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
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
        authorNameLabel.font = FontHelper.semiBold(withSize: 16.0)
        contentLabel.font = FontHelper.light(withSize: 15.0)
    }
    
    // MARK: - Reactive Behavior
    
    private func setupBindables() {
        authorNameLabel.text = viewModel?.authorName
        contentLabel.text = viewModel?.content
    }

}

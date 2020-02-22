//
//  MovieCreditCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieCreditCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var viewModel: MovieCreditCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            guard oldValue != isSelected else { return }
            if isSelected {
                overlayView.fadeOut(Constants.fadeAnimationDuration)
            } else {
                overlayView.fadeIn(Constants.fadeAnimationDuration, to: 0.6)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        subtitleLabel.text = nil
        profileImageView.image = nil
    }
    
    // MARK: - Private
    
    private func setupUI() {
        nameLabel.font = FontHelper.bold(withSize: 15.0)
        nameLabel.textColor = .white
        subtitleLabel.font = FontHelper.regular(withSize: 13.0)
        subtitleLabel.textColor = .white
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        profileImageView.setImage(with: viewModel.profileURL)
        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.role
    }
    
}

struct Constants {
    static let fadeAnimationDuration: Double = 0.25
}

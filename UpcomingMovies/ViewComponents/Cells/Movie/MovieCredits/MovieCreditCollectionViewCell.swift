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
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: MovieCreditCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
    
    private func setupUI() {
        
    }
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        profileImageView.setImage(with: viewModel.profileURL)
        nameLabel.text = viewModel.name
    }
    
}

//
//  CustomListDetailHeaderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CustomListDetailHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var posterImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var initialHeightConstraintConstant: CGFloat!
    var initialTopContstraintConstant: CGFloat!
    
    var viewModel: CustomListDetailHeaderViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        initialHeightConstraintConstant = posterImageViewHeightConstraint.constant
        initialTopContstraintConstant = posterImageViewTopConstraint.constant
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupLabels()
        setupImageViews()
    }
    
    private func setupLabels() {
        nameLabel.font = FontHelper.regular(withSize: 18.0)
        nameLabel.textColor = ColorPalette.darkBlueColor
        
        descriptionLabel.font = FontHelper.light(withSize: 16.0)
        descriptionLabel.textColor = ColorPalette.darkBlueColor
    }
    
    private func setupImageViews() {
        posterImageView.addOverlay()
    }
    
    // MARK: - Internal
    
    func setHeaderOffset(_ offset: CGFloat) {
        posterImageViewTopConstraint.constant = initialTopContstraintConstant - offset
    }
    
    func setPosterHeight(_ height: CGFloat) {
        posterImageViewHeightConstraint.constant = height
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        nameLabel.text = viewModel?.name
        if let description = viewModel?.description {
            descriptionLabel.text = description
        } else {
            descriptionView.isHidden = true
        }
        
        if let posterURL = viewModel?.posterURL {
            posterImageView.contentMode = .scaleAspectFill
            posterImageView.setImage(with: posterURL)
        } else {
            posterImageView.contentMode = .center
            posterImageView.image = #imageLiteral(resourceName: "PosterPlaceholder")
        }
    }

}

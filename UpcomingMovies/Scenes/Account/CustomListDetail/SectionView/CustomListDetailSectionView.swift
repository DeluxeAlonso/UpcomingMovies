//
//  CustomListDetailSectionView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CustomListDetailSectionView: UIView, NibLoadable {

    @IBOutlet weak var movieCountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    @IBOutlet var titleLabels: [UILabel]!
    
    var viewModel: CustomListDetailSectionViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        movieCountLabel.textColor = ColorPalette.whiteColor
        movieCountLabel.font = FontHelper.regular(withSize: 18.0)
        
        ratingLabel.textColor = ColorPalette.whiteColor
        ratingLabel.font = FontHelper.regular(withSize: 18.0)
        
        runtimeLabel.textColor = ColorPalette.whiteColor
        runtimeLabel.font = FontHelper.regular(withSize: 18.0)
        
        titleLabels.forEach { $0.textColor = ColorPalette.whiteColor }
        titleLabels.forEach { $0.font = FontHelper.light(withSize: 12.0) }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        movieCountLabel.text = viewModel?.movieCountText
        ratingLabel.text = viewModel?.ratingText
        runtimeLabel.text = viewModel?.runtimeText
    }
    
}

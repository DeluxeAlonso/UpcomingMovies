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
    @IBOutlet weak var filterButton: UIButton!
    
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
        movieCountLabel.textColor = ColorPalette.darkGray
        movieCountLabel.font = FontHelper.light(withSize: 18.0)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        movieCountLabel.text = viewModel?.movieCountText
    }
    
}

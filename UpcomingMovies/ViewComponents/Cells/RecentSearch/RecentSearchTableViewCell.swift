//
//  RecentSearchTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchLabel: UILabel!
    
    static let identifier = "RecentSearchCell"
    
    var viewModel: RecentSearchCellViewModel? {
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
    
    fileprivate func setupUI() {
        setupSearchLabel()
    }
    
    fileprivate func setupSearchLabel() {
        searchLabel.font = FontHelper.Default.mediumLight
        searchLabel.textColor = ColorPalette.darkGray
    }
    
    fileprivate func setupBindables() {
        searchLabel.text = viewModel?.searchText
    }
    
}

//
//  RecentSearchCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

final class RecentSearchCell: UITableViewCell {

    @IBOutlet private weak var searchLabel: UILabel!

    static let identifier = "RecentSearchCell"

    var viewModel: RecentSearchCellViewModelProtocol? {
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
        searchLabel.textColor = ColorPalette.Label.defaultColor
    }

    fileprivate func setupBindables() {
        searchLabel.text = viewModel?.searchText
    }

}

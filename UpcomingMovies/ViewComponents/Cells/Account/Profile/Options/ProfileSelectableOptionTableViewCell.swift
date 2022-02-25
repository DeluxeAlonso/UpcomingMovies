//
//  ProfileSelectableOptionTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class ProfileSelectableOptionTableViewCell: UITableViewCell {

    @IBOutlet private weak var titlelabel: UILabel!

    var viewModel: ProfileSelectableOptionCellViewModelProtocol? {
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
        titlelabel.font = FontHelper.calloutLight
        titlelabel.textColor = ColorPalette.lightBlueColor
        titlelabel.adjustsFontForContentSizeCategory = true
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        titlelabel.text = viewModel?.title
    }

}

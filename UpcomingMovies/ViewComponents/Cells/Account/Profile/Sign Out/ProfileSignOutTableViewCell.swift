//
//  ProfileSignOutTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class ProfileSignOutTableViewCell: UITableViewCell {

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Private

    private func setupUI() {
        textLabel?.text = LocalizedStrings.signOut()
        textLabel?.textAlignment = .center
        textLabel?.textColor = ColorPalette.redColor
        textLabel?.font = FontHelper.calloutLight
        textLabel?.adjustsFontForContentSizeCategory = true
    }

}

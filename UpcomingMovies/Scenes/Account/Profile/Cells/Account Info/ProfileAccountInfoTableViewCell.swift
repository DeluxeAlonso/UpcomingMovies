//
//  ProfileAccountInfoTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class ProfileAccountInfoTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!

    var viewModel: ProfileAccountInfoCellViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.borderColor = ColorPalette.Label.defaultColor.cgColor
    }

    // MARK: - Private

    private func setupUI() {
        selectionStyle = .none

        setupAvatarImageView()
        setupLabels()
    }

    private func setupAvatarImageView() {
        avatarImageView.layer.borderWidth = 4.0
    }

    private func setupLabels() {
        usernameLabel.font = FontHelper.body
        usernameLabel.textColor = ColorPalette.Label.defaultColor
        usernameLabel.textAlignment = .center
        usernameLabel.adjustsFontForContentSizeCategory = true

        nameLabel.font = FontHelper.footnote
        nameLabel.textColor = ColorPalette.regularGray
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontForContentSizeCategory = true
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        usernameLabel.text = viewModel.username
        nameLabel.text = viewModel.name
        avatarImageView.setImage(with: viewModel.avatarImageURL)
    }

}

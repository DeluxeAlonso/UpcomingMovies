//
//  ProfileAccountInfoTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class ProfileAccountInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var viewModel: ProfileAccountInforCellViewModel? {
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
        selectionStyle = .none
        setupLabels()
    }
    
    private func setupLabels() {
        usernameLabel.font = FontHelper.regular(withSize: 18.0)
        usernameLabel.textColor = ColorPalette.Label.defaultColor
        usernameLabel.textAlignment = .center
        
        nameLabel.font = FontHelper.light(withSize: 14.0)
        nameLabel.textColor = ColorPalette.lightGray
        nameLabel.textAlignment = .center
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        usernameLabel.text = viewModel.username
        nameLabel.text = viewModel.name
    }
    
}

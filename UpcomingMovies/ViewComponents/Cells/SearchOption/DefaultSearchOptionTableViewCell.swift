//
//  DefaultSearchOptionTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class DefaultSearchOptionTableViewCell: UITableViewCell {
    
    static let identifier = "DefaultSearchOptionCell"
    
    var viewModel: DefaultSearchOptionCellViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        textLabel?.font = FontHelper.regular(withSize: 14.0)
        textLabel?.textColor = ColorPalette.lightBlueColor
        
        detailTextLabel?.font = FontHelper.light(withSize: 12.0)
        detailTextLabel?.textColor = ColorPalette.lightBlueColor
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        textLabel?.text = viewModel?.title
        detailTextLabel?.text = viewModel?.subtitle
    }

}

//
//  RecentSearchesHeaderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class RecentSearchesHeaderView: UIView {
    
    fileprivate lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = Constants.titleText
        label.font = FontHelper.Default.mediumLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Private
    
    fileprivate func setupUI() {
        backgroundColor = ColorPalette.lighterGray
        setupLabel()
    }
    
    fileprivate func setupLabel() {
        addSubview(headerTitleLabel)
        
        NSLayoutConstraint.activate([headerTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalMargin),
                                     headerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalMargin),
                                     headerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalMargin),
                                     headerTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalMargin)])
    }
    
    // MARK: - Constants
    
    struct Constants {
        
        static let horizontalMargin: CGFloat = 16.0
        static let verticalMargin: CGFloat = 8.0
        
        static let titleText = "Recent searches"
        
    }
    
}

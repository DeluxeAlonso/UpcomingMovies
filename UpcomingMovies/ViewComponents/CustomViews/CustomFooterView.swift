//
//  CustomFooterView.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class CustomFooterView: UIView {
    
    static let recommendedFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
    
    fileprivate lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontHelper.Default.mediumLight
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Public
    
    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    fileprivate func setupUI() {
        addSubview(messageLabel)
        NSLayoutConstraint.activate([messageLabel.topAnchor.constraint(equalTo: topAnchor),
                                     messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalMargin),
                                     messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalMargin),
                                     messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    // MARK: - Constants
    
    struct Constants {
        static let horizontalMargin: CGFloat = 8.0
    }
    
}

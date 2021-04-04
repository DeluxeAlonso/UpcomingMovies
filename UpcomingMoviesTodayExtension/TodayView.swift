//
//  TodayView.swift
//  UpcomingMoviesTodayExtension
//
//  Created by Alonso on 5/10/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class TodayView: UIView {
    
    lazy var postersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupPostersStackView()
    }
    
    private func setupPostersStackView() {
        addSubview(postersStackView)

        NSLayoutConstraint.activate([
            postersStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            postersStackView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 8)
        ])
        
        postersStackView.centerInSuperview()
    }
    
    // MARK: - Internal
    
    func setupEmptyView() {
        let emptyLabel = UILabel()
        emptyLabel.text = "No recent movies to show"
        emptyLabel.textAlignment = .center
        
        addSubview(emptyLabel)
        
        emptyLabel.fillSuperview()
    }
    
    func addPoster(with posterPath: String) {
        let imageView = UIImageView()
        imageView.constraintHeight(constant: 100)
        imageView.constraintWidthAspectRatio(constant: 1/1.5)
        
        postersStackView.addArrangedSubview(imageView)
        
        if let posterURL = URL(string: posterPath) {
            imageView.setImage(with: posterURL)
        }
    }
    
}

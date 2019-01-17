//
//  LoadingFooterView.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class LoadingFooterView: UIView {
    
    static let recommendedFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
    
    fileprivate lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .gray
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
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
        setupActivityIndicatorView()
    }
    
    fileprivate func setupActivityIndicatorView() {
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    // MARK: - Public
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
    
}

//
//  LoadingFooterView.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class LoadingFooterView: UIView {

    static let recommendedFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: LoadingFooterView.recommendedFrame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Private

    private func setupUI() {
        setupActivityIndicatorView()
    }

    private func setupActivityIndicatorView() {
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }

    // MARK: - Internal

    func startAnimating() {
        activityIndicatorView.startAnimating()
    }

    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }

}

//
//  TodayViewController.swift
//  UpcomingMoviesWidget
//
//  Created by Alonso on 5/9/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreDataInfrastructure

@objc(TodayViewController)
class TodayViewController: UIViewController, NCWidgetProviding {
    
    lazy var backgroundVibrancyView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIVibrancyEffect.widgetPrimary()
        return visualEffectView
    }()
    
    lazy var postersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupBackgroundView()
        setupMoviePosters()
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundVibrancyView)
        backgroundVibrancyView.fillSuperview()
    }
    
    private func setupMoviePosters() {
        let localDataSource = LocalDataSource()
        let posters = localDataSource.movieVisitDataSource().getMovieVisits().compactMap { $0.posterPath }
        posters.isEmpty ? setupEmptyView() : setupPostersStackView(with: posters)
    }
    
    private func setupEmptyView() {
        let emptyLabel = UILabel()
        emptyLabel.text = "No recent movies to show"
        emptyLabel.textAlignment = .center
        
        backgroundVibrancyView.contentView.addSubview(emptyLabel)
        
        emptyLabel.fillSuperview()
    }
    
    private func setupPostersStackView(with posters: [String]) {
        backgroundVibrancyView.contentView.addSubview(postersStackView)

        NSLayoutConstraint.activate([
            postersStackView.leadingAnchor.constraint(greaterThanOrEqualTo: backgroundVibrancyView.contentView.leadingAnchor, constant: 8),
            postersStackView.trailingAnchor.constraint(greaterThanOrEqualTo: backgroundVibrancyView.contentView.trailingAnchor, constant: 8)
        ])
        
        postersStackView.centerInSuperview()
        
        posters.forEach { poster in
            let imageView = UIImageView()
            imageView.constrainHeight(constant: 100)
            imageView.constraintWidthAspectRatio(constant: 1/1.5)

            postersStackView.addArrangedSubview(imageView)
            
            if let posterURL = URL(string: poster) {
                imageView.setImage(with: posterURL)
            }
        }
    }
    
}

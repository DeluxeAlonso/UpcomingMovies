//
//  TodayViewController.swift
//  UpcomingMoviesTodayExtension
//
//  Created by Alonso on 5/9/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreDataInfrastructure

@objc(TodayViewController)
class TodayViewController: UIViewController, NCWidgetProviding {
    
    private let todayView: TodayView = TodayView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = todayView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(openHostApp))
        todayView.addGestureRecognizer(tapGesture)
        configureMoviePosters()
    }

    private func configureMoviePosters() {
        let localDataSource = LocalDataSource(appGroupExtensions: ["group.movies.extension"])
        let movieVisits = localDataSource.movieVisitDataSource().getMovieVisits()
        // We only take the 3 latest visited movies
        let posterPaths = Array(movieVisits.compactMap { $0.posterPath }.prefix(3))
        posterPaths.isEmpty ? todayView.setupEmptyView() : configurePostersStackView(with: posterPaths)
    }
    
    private func configurePostersStackView(with posterPaths: [String]) {
        posterPaths.forEach { posterPath in
            todayView.addPoster(with: posterPath)
        }
    }
    
    // MARK: - Selectors
    
    @objc private func openHostApp() {
        guard let url = URL(string: "extension://search") else { return }
        self.extensionContext?.open(url, completionHandler: nil)
    }
    
}

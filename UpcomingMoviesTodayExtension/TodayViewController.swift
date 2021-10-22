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

    private var localDataSource: LocalDataSource!

    // MARK: - Lifecycle

    override func loadView() {
        view = todayView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - NCWidgetProviding

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }

    // MARK: - Private

    private func configureUI() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(openHostApp))
        todayView.addGestureRecognizer(tapGesture)
        configureMoviePosters()
    }

    private func configureMoviePosters() {
        localDataSource = LocalDataSource(appGroupExtensions: AppGroup.allCasesIdentifiers)
        localDataSource.movieVisitDataSource().getMovieVisits(completion: { [weak self] result in
            guard let self = self else { return }
            guard let movieVisits = try? result.get() else { return }

            // We only take the 3 latest visited movies
            let posterPaths = Array(movieVisits.compactMap { $0.posterPath }.prefix(3))
            posterPaths.isEmpty ? self.todayView.setupEmptyView() : self.configurePostersStackView(with: posterPaths)
        })
    }

    private func configurePostersStackView(with posterPaths: [String]) {
        posterPaths.forEach { posterPath in
            todayView.addPoster(with: posterPath)
        }
    }

    // MARK: - Selectors

    @objc private func openHostApp() {
        guard let url = AppExtension.url(for: .searchMovies) else { return }
        self.extensionContext?.open(url, completionHandler: nil)
    }

}

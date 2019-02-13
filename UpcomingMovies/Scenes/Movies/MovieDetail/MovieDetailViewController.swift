//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class MovieDetailViewController: UIViewController, Transitionable, SegueHandler {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var transitionContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageView: VoteAverageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    private var managedObjectContext: NSManagedObjectContext {
        guard let appDelegate = appDelegate else { fatalError() }
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private
    
    private func setupUI() {
        title = "Movie detail"
        setupNavigationBar()
        transitionContainerView.setShadowBorder()
    }
    
    private func setupNavigationBar() {
        let shareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBarButtonAction))
        navigationItem.rightBarButtonItem = shareBarButtonItem
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        releaseDateLabel.text = viewModel.releaseDate
        
        backdropImageView.kf.indicatorType = .activity
        backdropImageView.kf.setImage(with: viewModel.backdropURL)
        
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: viewModel.posterURL)
        
        voteAverageView.voteValue = viewModel.voteAverage
        overviewLabel.text = viewModel.overview
        viewModel.saveVisitedMovie(managedObjectContext)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.delegate = nil
        switch segueIdentifier(for: segue) {
        case .movieVideos:
            guard let viewController = segue.destination as? MovieVideosViewController else { fatalError() }
            _ = viewController.view
            viewController.viewModel = viewModel?.buildVideosViewModel()
        case .movieReviews:
            guard let viewController = segue.destination as? MovieReviewsViewController else { fatalError() }
            _ = viewController.view
            viewController.viewModel = viewModel?.buildReviewsViewModel()
        case .movieSimilars:
            guard let viewController = segue.destination as? MovieListViewController else { fatalError() }
            viewController.viewModel = viewModel!.buildSimilarsViewModel()
        }
    }
    
    // MARK: - Selectors
    
    @objc func shareBarButtonAction() {
        guard let movieTitle = viewModel?.title else { return }
        let shareText = "Come with me to watch \(movieTitle)!"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - Options Actions
    
    @IBAction func trailersOptionAction(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.movieVideos.rawValue, sender: nil)
    }
    
    @IBAction func reviewsOptionAction(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.movieReviews.rawValue, sender: nil)
    }
    
    @IBAction func similarsOptionAction(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.movieSimilars.rawValue, sender: nil)
    }
    
}

// MARK: - Segue Identifiers

extension MovieDetailViewController {
    
    enum SegueIdentifier: String {
        case movieVideos = "MovieVideosSegue"
        case movieReviews = "MovieReviewsSegue"
        case movieSimilars = "MovieSimilarsSegue"
    }
    
}

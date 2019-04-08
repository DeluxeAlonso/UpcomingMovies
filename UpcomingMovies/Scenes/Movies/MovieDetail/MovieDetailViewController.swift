//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController, FullscreenRetryable, Transitionable, SegueHandler, LoaderDisplayable {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var transitionContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageView: VoteAverageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var loaderView: RadarView!
    
    var viewModel: MovieDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    deinit {
        print("MovieDetailViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel, !viewModel.startLoading.value else {
            return
        }
        viewModel.checkIfUserIsAuthenticated()
    }

    // MARK: - Private
    
    private func setupUI() {
        title = "Movie detail"
        setupNavigationBar()
        transitionContainerView.setShadowBorder()
    }
    
    private func setupNavigationBar() {
        let backItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        let shareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBarButtonAction))
        navigationItem.rightBarButtonItem = shareBarButtonItem
    }
    
    private func showErrorView(error: Error) {
        presentFullScreenErrorView(withErrorMessage: error.localizedDescription,
                                   errorHandler: { [weak self] in
            self?.viewModel?.getMovieDetail()
        })
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        setupViewBindables()
        setupLoaderBindable()
        setupErrorBindables()
        setupFavoriteBindables()
        viewModel?.getMovieDetail()
    }
    
    private func setupViewBindables() {
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
    }
    
    private func setupLoaderBindable() {
        viewModel?.startLoading.bind({ [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        })
        viewModel?.updateMovieDetail = { [weak self] in
            self?.setupViewBindables()
        }
    }
    
    private func setupErrorBindables() {
        viewModel?.showErrorView = { [weak self] error in
            self?.showErrorView(error: error)
        }
    }
    
    private func setupFavoriteBindables() {
        viewModel?.isFavorite.bind({ [weak self] isFavorite in
            guard let strongSelf = self else { return }
            strongSelf.favoriteView.isHidden = isFavorite == nil
            if let isFavorite = isFavorite {
                let favoriteIcon = isFavorite ? #imageLiteral(resourceName: "FavoriteOn") : #imageLiteral(resourceName: "FavoriteOff")
                strongSelf.favoriteButton.setImage(favoriteIcon, for: .normal)
            }
        })
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
        case .movieCredits:
            guard let viewController = segue.destination as? MovieCreditsViewController else { fatalError() }
            _ = viewController.view
            viewController.viewModel = viewModel?.buildCreditsViewModel()
        case .movieSimilars:
            guard let viewController = segue.destination as? MovieListViewController else { fatalError() }
            _ = viewController.view
            viewController.viewModel = viewModel!.buildSimilarsViewModel()
        }
    }
    
    // MARK: - Selectors
    
    @objc func shareBarButtonAction() {
        guard let movieTitle = viewModel?.title else { return }
        let shareText = "Come with me to watch \(movieTitle)!"
        let activityViewController = UIActivityViewController(activityItems: [shareText],
                                                              applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        viewModel?.handleFavoriteMovie()
    }
    
    @IBAction func trailersOptionAction(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.movieVideos.rawValue, sender: nil)
    }
    
    @IBAction func reviewsOptionAction(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.movieReviews.rawValue, sender: nil)
    }
    
    @IBAction func creditsOptionAction(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.movieCredits.rawValue, sender: nil)
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
        case movieCredits = "MovieCreditsSegue"
    }
    
}

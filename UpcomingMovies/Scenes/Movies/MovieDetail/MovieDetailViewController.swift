//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController, Retryable, Transitionable, SegueHandler, Loadable {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var transitionContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageView: VoteAverageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    lazy var shareBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBarButtonAction(_:)))
        return barButtonItem
    }()
    
    lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "FavoriteOff"), style: .plain, target: self, action: #selector(favoriteButtonAction(_:)))
        return barButtonItem
    }()
    
    var loaderView: RadarView!
    
    var viewModel: MovieDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
      
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
        navigationItem.rightBarButtonItems = [shareBarButtonItem, favoriteBarButtonItem]
    }
    
    private func configureNavigationBar(isFavorite: Bool?) {
        if let isFavorite = isFavorite {
            favoriteBarButtonItem.image = isFavorite ? #imageLiteral(resourceName: "FavoriteOn") : #imageLiteral(resourceName: "FavoriteOff")
            navigationItem.rightBarButtonItems = [shareBarButtonItem, favoriteBarButtonItem]
        } else {
            navigationItem.rightBarButtonItems = [shareBarButtonItem]
        }
    }
    
    private func showErrorView(error: Error) {
        presentErrorView(with: error.localizedDescription,
                                   errorHandler: { [weak self] in
            self?.viewModel?.refreshMovieDetail()
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
            self?.hideErrorView()
        }
    }
    
    private func setupErrorBindables() {
        viewModel?.showErrorView.bind({ [weak self] error in
            guard let error = error else { return }
            self?.showErrorView(error: error)
        })
    }
    
    private func setupFavoriteBindables() {
        viewModel?.isFavorite.bind({ [weak self] isFavorite in
            guard let strongSelf = self else { return }
            strongSelf.configureNavigationBar(isFavorite: isFavorite)
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
    
    // MARK: - Actions
    
    @IBAction func shareBarButtonAction(_ sender: Any) {
        guard let movieTitle = viewModel?.title else { return }
        let shareText = "Come with me to watch \(movieTitle)!"
        let activityViewController = UIActivityViewController(activityItems: [shareText],
                                                              applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
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

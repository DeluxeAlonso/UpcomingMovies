//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, Retryable, Transitionable, Loadable {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var transitionContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageView: VoteAverageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var optionsStackView: UIStackView!
    
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
        
        backdropImageView.setImage(with: viewModel.backdropURL)
        posterImageView.setImage(with: viewModel.posterURL)
        
        voteAverageView.voteValue = viewModel.voteAverage
        overviewLabel.text = viewModel.overview
        
        configureOptionsStackView()
    }
    
    private func configureOptionsStackView() {
        guard let viewModel = viewModel, optionsStackView.arrangedSubviews.isEmpty else { return }
        let optionsViews = viewModel.options.map { MovieDetailOptionView(option: $0) }
        for optionView in optionsViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(optionAction(_:)))
            optionView.addGestureRecognizer(tapGesture)
            optionsStackView.addArrangedSubview(optionView)
        }
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
        guard let option = sender as? MovieDetailOption,
            let viewModel = viewModel else {
            return
        }
        var viewController = segue.destination
        option.prepare(viewController: &viewController, with: viewModel)
    }
    
    // MARK: - Selectors
    
    @objc func optionAction(_ sender: UITapGestureRecognizer) {
        guard let sender = sender.view as? MovieDetailOptionView,
            let segueIdentifier = sender.identifier else {
                return
        }
        performSegue(withIdentifier: segueIdentifier, sender: sender.option)
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
    
}

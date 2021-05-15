//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded, Retryable, Transitionable, LoadingDisplayable {

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
    
    static var storyboardName: String = "MovieDetail"
    
    private lazy var shareBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBarButtonAction(_:)))
        return barButtonItem
    }()
    
    private lazy var favoriteBarButtonItem: FavoriteToggleBarButtonItem = {
        let barButtonItem = FavoriteToggleBarButtonItem()
        barButtonItem.target = self
        barButtonItem.action = #selector(favoriteButtonAction(_:))
        
        return barButtonItem
    }()

    var viewModel: MovieDetailViewModelProtocol?
    weak var coordinator: MovieDetailCoordinatorProtocol?

    // MARK: - LoadingDisplayable

    var loaderView: LoadingView = RadarView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.getMovieDetail()
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
        title = LocalizedStrings.movieDetailTitle()

        setupNavigationBar()
        transitionContainerView.setShadowBorder()
    }
    
    private func setupNavigationBar() {
        let backItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        navigationItem.rightBarButtonItems = [shareBarButtonItem]
    }
    
    private func configureNavigationBar(isFavorite: Bool?) {
        if let isFavorite = isFavorite {
            favoriteBarButtonItem.toggle(to: isFavorite.intValue)
            navigationItem.rightBarButtonItems = [shareBarButtonItem, favoriteBarButtonItem]
        } else {
            navigationItem.rightBarButtonItems = [shareBarButtonItem]
        }
    }
    
    private func showErrorView(error: Error) {
        presentRetryView(with: error.localizedDescription, errorHandler: { [weak self] in
            self?.viewModel?.refreshMovieDetail()
        })
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        setupViewBindables()
        setupLoaderBindable()
        setupErrorBindables()
        setupFavoriteBindables()
    }
    
    private func setupViewBindables() {
        configureUI()

        viewModel?.updateMovieDetail = { [weak self] in
            self?.configureUI()
            self?.hideRetryView()
        }
        viewModel?.showGenreName.bindAndFire({ [weak self] genreName in
            self?.genreLabel.text = genreName
        })
        viewModel?.showMovieOptions.bindAndFire { [weak self] movieOptions in
            self?.configureMovieOptions(movieOptions)
        }
    }

    private func configureUI() {
        guard let viewModel = viewModel else { return }

        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        releaseDateLabel.text = viewModel.releaseDate

        backdropImageView.setImage(with: viewModel.backdropURL)
        posterImageView.setImage(with: viewModel.posterURL)

        voteAverageView.voteValue = viewModel.voteAverage
        overviewLabel.text = viewModel.overview
    }
    
    private func configureMovieOptions(_ options: [MovieDetailOption]) {
        guard optionsStackView.arrangedSubviews.isEmpty else { return }
        let optionsViews = options.map { MovieDetailOptionView(option: $0) }
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
        viewModel?.didUpdateFavoriteSuccess.bind({ [weak self] isFavorite in
            guard let strongSelf = self else { return }
            let message = isFavorite ? LocalizedStrings.addToFavoritesSuccess() : LocalizedStrings.removeFromFavoritesSuccess()
            strongSelf.view.showSuccessToast(withMessage: message)
        })
        viewModel?.didUpdateFavoriteFailure.bind({ [weak self] error in
            guard let strongSelf = self, let error = error else { return }
            strongSelf.view.showFailureToast(withMessage: error.localizedDescription)
        })
    }
    
    // MARK: - Selectors
    
    @objc func optionAction(_ sender: UITapGestureRecognizer) {
        guard let sender = sender.view as? MovieDetailOptionView else { return }
        let movieDetailOption = sender.option
        coordinator?.showMovieOption(movieDetailOption)
    }
    
    // MARK: - Actions
    
    @IBAction func shareBarButtonAction(_ sender: Any) {
        guard let movieTitle = viewModel?.title else { return }
        let shareText = String(format: LocalizedStrings.movieDetailShareText(), movieTitle)
        coordinator?.showSharingOptions(withShareTitle: shareText)
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        viewModel?.handleFavoriteMovie()
    }
    
}

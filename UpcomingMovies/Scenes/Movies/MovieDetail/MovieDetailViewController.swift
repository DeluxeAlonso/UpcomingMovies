//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded, Retryable, Transitionable, LoadingDisplayable {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var voteAverageView: VoteAverageView!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var optionsStackView: UIStackView!
    @IBOutlet private(set) weak var transitionContainerView: UIView!
    
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
        viewModel.checkIfMovieIsFavorite(showLoader: false)
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
    
    private func showErrorView(error: Error) {
        presentRetryView(with: error.localizedDescription, errorHandler: { [weak self] in
            self?.viewModel?.refreshMovieDetail()
        })
    }
    
    // MARK: - Reactive Behavior
    
    private func setupBindables() {
        setupViewBindables()
        setupLoaderBindable()
        setupErrorBindables()
        setupFavoriteBindables()
    }
    
    private func setupViewBindables() {
        viewModel?.didUpdateMovieDetail.bindAndFire { [weak self] _ in
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
            strongSelf.favoriteBarButtonItem.toggle(to: isFavorite.intValue)
            strongSelf.navigationItem.rightBarButtonItems = [strongSelf.shareBarButtonItem, strongSelf.favoriteBarButtonItem]
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
        viewModel?.shouldHideFavoriteButton = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationItem.rightBarButtonItems = [strongSelf.shareBarButtonItem]
        }
    }
    
    // MARK: - Selectors
    
    @objc private func optionAction(_ sender: UITapGestureRecognizer) {
        guard let sender = sender.view as? MovieDetailOptionView else { return }
        let movieDetailOption = sender.option
        coordinator?.showMovieOption(movieDetailOption)
    }
    
    // MARK: - Actions
    
    @IBAction private func shareBarButtonAction(_ sender: Any) {
        guard let movieTitle = viewModel?.title else { return }
        let shareText = String(format: LocalizedStrings.movieDetailShareText(), movieTitle)
        coordinator?.showSharingOptions(withShareTitle: shareText)
    }
    
    @IBAction private func favoriteButtonAction(_ sender: Any) {
        viewModel?.handleFavoriteMovie()
    }
    
}

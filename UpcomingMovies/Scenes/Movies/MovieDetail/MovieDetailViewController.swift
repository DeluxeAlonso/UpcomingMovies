//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded, Transitionable {

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

    private lazy var moreBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "Ellipsis"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(moreBarButtonAction(_:)))
        return barButtonItem
    }()

    private lazy var favoriteBarButtonItem: FavoriteToggleBarButtonItem = {
        let barButtonItem = FavoriteToggleBarButtonItem()
        barButtonItem.target = self
        barButtonItem.action = #selector(favoriteButtonAction(_:))

        return barButtonItem
    }()

    var viewModel: MovieDetailViewModelProtocol?
    var userInterfaceHelper: MovieDetailUIHelperProtocol?
    weak var coordinator: MovieDetailCoordinatorProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.getMovieDetail(showLoader: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel, !viewModel.startLoading.value else {
            return
        }
        viewModel.checkMovieAccountState()
    }

    // MARK: - Private

    private func setupUI() {
        title = LocalizedStrings.movieDetailTitle()

        setupNavigationBar()
        setupLabels()

        transitionContainerView.setShadowBorder()
    }

    private func setupNavigationBar() {
        let backItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        navigationItem.rightBarButtonItems = [moreBarButtonItem]
    }

    private func setupLabels() {
        titleLabel.font = FontHelper.headline
        titleLabel.adjustsFontForContentSizeCategory = true

        genreLabel.font = FontHelper.body
        genreLabel.adjustsFontForContentSizeCategory = true

        releaseDateLabel.font = FontHelper.body
        releaseDateLabel.adjustsFontForContentSizeCategory = true

        overviewLabel.font = FontHelper.body
        overviewLabel.adjustsFontForContentSizeCategory = true
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        setupViewBindables()
        setupLoaderBindable()
        setupErrorBindables()
        setupAlertBindables()
    }

    private func setupViewBindables() {
        viewModel?.didSetupMovieDetail.bindAndFire { [weak self] _ in
            self?.configureUI()
            self?.userInterfaceHelper?.hideRetryView()
            self?.viewModel?.saveVisitedMovie()
        }
        viewModel?.showGenreName.bindAndFire({ [weak self] genreName in
            self?.genreLabel.text = genreName
        })
        viewModel?.showMovieOptions.bindAndFire { [weak self] movieOptions in
            self?.configureMovieOptions(movieOptions)
        }
        viewModel?.didSelectShareAction.bind { [weak self] _ in
            self?.shareMovie()
        }
        viewModel?.movieAccountState.bindAndFire({ [weak self] accountState in
            guard let self = self else { return }
            guard let accountState = accountState else {
                // We remove favorite button from navigation bar.
                self.navigationItem.rightBarButtonItems = [self.moreBarButtonItem]
                return
            }
            let isFavorite = accountState.isFavorite
            self.favoriteBarButtonItem.toggle(to: isFavorite.intValue)
            self.navigationItem.rightBarButtonItems = [self.moreBarButtonItem, self.favoriteBarButtonItem]
        })
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
            guard let self = self else { return }
            if start {
                self.userInterfaceHelper?.showFullscreenLoader(in: self.view)
            } else {
                self.userInterfaceHelper?.dismissFullscreenLoader()
            }
        })
    }

    private func setupErrorBindables() {
        viewModel?.showErrorRetryView.bind({ [weak self] error in
            guard let self = self, let error = error else { return }
            self.showErrorView(error: error)
        })
    }

    private func setupAlertBindables() {
        viewModel?.showSuccessAlert.bind({ [weak self] message in
            guard let self = self else { return }
            self.userInterfaceHelper?.showHUD(with: message, in: self.view)
        })
        viewModel?.showErrorAlert.bind({ [weak self] error in
            guard let self = self, let error = error else { return }
            self.view.showFailureToast(withMessage: error.localizedDescription)
        })
    }

    private func showErrorView(error: Error) {
        userInterfaceHelper?.presentRetryView(in: self.view, with: error.localizedDescription, retryHandler: { [weak self] in
            self?.viewModel?.getMovieDetail(showLoader: false)
        })
    }

    // MARK: - Selectors

    @objc private func optionAction(_ sender: UITapGestureRecognizer) {
        guard let sender = sender.view as? MovieDetailOptionView else { return }
        let movieDetailOption = sender.option
        coordinator?.showMovieOption(movieDetailOption)
    }

    // MARK: - Actions

    @IBAction private func moreBarButtonAction(_ sender: Any) {
        guard let movieTitle = viewModel?.title,
        let actions = viewModel?.getAvailableAlertActions() else { return }
        let alertActions = actions.map { actionModel in
            UIAlertAction(title: actionModel.title, style: .default) { _ in actionModel.action() }
        }
        showActionSheet(title: movieTitle, message: nil, actions: alertActions)
    }

    private func shareMovie() {
        guard let movieTitle = viewModel?.title else { return }
        let shareText = String(format: LocalizedStrings.movieDetailShareText(), movieTitle)
        coordinator?.showSharingOptions(withShareTitle: shareText)
    }

    @IBAction private func favoriteButtonAction(_ sender: Any) {
        viewModel?.handleFavoriteMovie()
    }

}

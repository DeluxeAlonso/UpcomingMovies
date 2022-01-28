//
//  MovieCreditsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieCreditsViewController: UIViewController, Storyboarded, PlaceholderDisplayable, LoadingDisplayable {

    @IBOutlet private weak var collectionView: UICollectionView!

    static var storyboardName = "MovieDetail"

    private var displayedCellsIndexPaths = Set<IndexPath>()
    private var dataSource: MovieCreditsDataSource!

    var viewModel: MovieCreditsViewModelProtocol?
    weak var coordinator: MovieCreditsCoordinatorProtocol?

    // MARK: - LoadingDisplayable

    var loaderView: LoadingView = RadarView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.getMovieCredits(showLoader: true)
    }

    // MARK: - Private

    private func setupUI() {
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        collectionView.registerNib(cellType: MovieCreditCell.self)

        setupCollectionViewLayout()
    }

    private func setupCollectionViewLayout() {
        let previewLayoutWidth = Constants.creditCellHeight / CGFloat(UIConstants.posterAspectRatio)
        let layout = VerticalFlowLayout(preferredWidth: previewLayoutWidth,
                                        preferredHeight: Constants.creditCellHeight,
                                        minColumns: 2)
        layout.headerReferenceSize = .init(width: collectionView.frame.width,
                                           height: Constants.creditSectionCellHeight)

        collectionView.collectionViewLayout = layout
    }

    private func configureView(with state: MovieCreditsViewState) {
        switch state {
        case .populated, .initial:
            hideDisplayedPlaceholderView()
        case .empty:
            presentEmptyView(with: LocalizedStrings.emptyCreditReults())
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                                       retryHandler: { [weak self] in
                                        self?.viewModel?.getMovieCredits(showLoader: false)
            })
        }
    }

    private func reloadCollectionView() {
        guard let viewModel = viewModel else { return }
        dataSource = MovieCreditsDataSource(viewModel: viewModel)

        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        title = viewModel.movieTitle

        viewModel.viewState.bind({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.configureView(with: state)
                strongSelf.reloadCollectionView()
            }
        })

        viewModel.didToggleSection.bind({ [weak self] sectionToggled in
            guard let strongSelf = self else { return }
            strongSelf.collectionView.performBatchUpdates({
                strongSelf.collectionView.reloadSections(IndexSet(integer: sectionToggled))
            }, completion: nil)
        })

        viewModel.startLoading.bind({ [weak self] start in
            DispatchQueue.main.async {
                start ? self?.showLoader() : self?.hideLoader()
            }
        })
    }

}

// MARK: - UICollectionViewDelegate

extension MovieCreditsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            CollectionViewCellAnimator.fadeAnimate(cell: cell)
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieCreditsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let viewModel = viewModel,
              viewModel.numberOfItems(for: section) != 0 else {
            return .zero
        }
        return UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    }

}

// MARK: - Constants

extension MovieCreditsViewController {

    struct Constants {

        static let creditCellHeight: CGFloat = 150.0
        static let creditSectionCellHeight: CGFloat = 60.0

    }

}

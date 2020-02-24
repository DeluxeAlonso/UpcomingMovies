//
//  MovieCreditsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieCreditsViewController: UIViewController, PlaceholderDisplayable, Loadable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var displayedCellsIndexPaths = Set<IndexPath>()
    private var wasSectionManuallyToggled = false
    
    var loaderView: RadarView!
    
    var viewModel: MovieCreditsViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.registerNib(cellType: MovieCreditCollectionViewCell.self)
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInsetReference = .fromSafeArea
        }
    }
    
    private func configureView(with state: MovieCreditsViewModel.ViewState) {
        switch state {
        case .populated, .initial:
            hideDisplayedPlaceholderView()
        case .empty:
            presentEmptyView(with: "No credits to show")
        case .error(let error):
            presentErrorView(with: error.localizedDescription,
                                       errorHandler: { [weak self] in
                               self?.viewModel?.getMovieCredits()
            })
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        title = viewModel.movieTitle
        viewModel.viewState.bind({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.configureView(with: state)
                strongSelf.collectionView.reloadData()
            }
        })
        viewModel.startLoading.bind({ [weak self] start in
            DispatchQueue.main.async {
                start ? self?.showLoader() : self?.hideLoader()
            }
        })
        viewModel.getMovieCredits(showLoader: true)
    }

}

extension MovieCreditsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.rowCount(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { fatalError() }
        let cell = collectionView.dequeueReusableCell(with: MovieCreditCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.credit(for: indexPath.section, and: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = viewModel else { fatalError() }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "CollapsibleCollectionHeaderView",
                                                                     for: indexPath) as! CollapsibleCollectionHeaderView
        header.viewModel = viewModel.headerModel(for: indexPath.section)
        header.delegate = self
        header.updateArrowImageView(animated: wasSectionManuallyToggled)
        if wasSectionManuallyToggled { wasSectionManuallyToggled.toggle() }
        return header
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
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let posterHeight: Double = 150.0
        let posterWidth: Double = 100.0
        return CGSize(width: posterWidth, height: posterHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let viewModel = viewModel,
            viewModel.rowCount(for: section) != 0 else {
                return .zero
        }
        return UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    }

}

extension MovieCreditsViewController: CollapsibleHeaderViewViewDelegate {
    
    func collapsibleHeaderView(sectionHeaderView: CollapsibleCollectionHeaderView, sectionToggled section: Int) {
        guard let viewModel = viewModel else { return }
        viewModel.toggleSection(section)
        wasSectionManuallyToggled = true
        collectionView.performBatchUpdates({
            self.collectionView.reloadSections(IndexSet(integer: section))
        }, completion: nil)
    }
    
}

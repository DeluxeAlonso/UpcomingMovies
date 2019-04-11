//
//  MovieCreditsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieCreditsViewController: UIViewController, Displayable, LoaderDisplayable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
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
        collectionView.registerNib(cellType: MovieCreditCollectionViewCell.self)
        collectionView.backgroundView = LoadingFooterView()
    }
    
    private func configureView(with state: MovieCreditsViewModel.ViewState) {
        switch state {
        case .populated, .initial:
            collectionView.backgroundView = nil
            hideFullscreenDisplayedView()
        case .empty:
            presentFullScreenEmptyView(with: "No credits to show")
        case .error(let error):
            presentFullScreenErrorView(withErrorMessage: error.localizedDescription,
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
        viewModel.startLoading = { [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        }
        viewModel.getMovieCredits()
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
        let posterHeight: Double = 200.0
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
        let opened = viewModel.toggleSection(section)
        sectionHeaderView.updateArrowImageView(opened: opened, animated: true)
        collectionView.performBatchUpdates({
            self.collectionView.reloadSections(IndexSet(integer: section))
        }, completion: nil)
    }
    
}

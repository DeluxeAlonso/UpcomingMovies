//
//  MovieCreditsDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/29/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class MovieCreditsDataSource: NSObject, UICollectionViewDataSource {
    
    private let viewModel: MovieCreditsViewModelProtocol
    private let collapsibleHeaderDelegate: CollapsibleHeaderViewDelegate
    
    private var isAnimationEnabled = false
    
    // MARK: - Initializers
    
    init(viewModel: MovieCreditsViewModelProtocol,
         collapsibleHeaderDelegate: CollapsibleHeaderViewDelegate) {
        self.viewModel = viewModel
        self.collapsibleHeaderDelegate = collapsibleHeaderDelegate
    }
    
    // MARK: - Public
    
    func enableAnimation() {
        isAnimationEnabled = true
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rowCount(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieCreditCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.credit(for: indexPath.section, and: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "CollapsibleCollectionHeaderView",
                                                                     for: indexPath) as! CollapsibleCollectionHeaderView
        header.viewModel = viewModel.headerModel(for: indexPath.section)
        header.delegate = collapsibleHeaderDelegate
        header.updateArrowImageView(animated: isAnimationEnabled)
        if isAnimationEnabled { isAnimationEnabled.toggle() }
        return header
    }
    
}

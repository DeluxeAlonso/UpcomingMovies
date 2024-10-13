//
//  CollapsibleHeaderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/14/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol CollapsibleHeaderViewDelegate: AnyObject {

    func collapsibleHeaderView(sectionHeaderView: CollapsibleCollectionHeaderView, sectionToggled section: Int)

}

class CollapsibleCollectionHeaderView: UICollectionReusableView {

    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var arrowImageView: UIImageView!

    weak var delegate: CollapsibleHeaderViewDelegate?

    var viewModel: CollapsibleHeaderViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        backgroundColor = ColorPalette.defaultGrayBackgroundColor
        isAccessibilityElement = true

        setupTapGesture()
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tapGestureAction))
        addGestureRecognizer(tapGesture)
    }

    private func setupBindables() {
        accessibilityLabel = viewModel?.title
        titleLabel.text = viewModel?.title
    }

    func updateArrowImageView(animated: Bool) {
        guard let viewModel = viewModel else { return }
        arrowImageView.rotate(viewModel.arrowRotationValue(), duration: animated ? 0.3 : 0.0)
    }

    // MARK: - Selector

    @objc func tapGestureAction() {
        guard let viewModel = viewModel else { return }
        delegate?.collapsibleHeaderView(sectionHeaderView: self, sectionToggled: viewModel.section)
    }

}

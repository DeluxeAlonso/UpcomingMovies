//
//  CollapsibleHeaderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/14/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol CollapsibleHeaderViewViewDelegate: class {

    func collapsibleHeaderView(sectionHeaderView: CollapsibleCollectionHeaderView, sectionToggled section: Int)

}

final class CollapsibleHeaderViewModel {

    var opened: Bool
    var section: Int
    var title: String

    init(opened: Bool, section: Int, title: String) {
        self.opened = opened
        self.section = section
        self.title = title
    }

}

class CollapsibleCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!

    var viewModel: CollapsibleHeaderViewModel? {
        didSet {
            setupBindables()
        }
    }

    weak var delegate: CollapsibleHeaderViewViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        setupTapGesture()
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tapGestureAction))
        addGestureRecognizer(tapGesture)
    }

    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        updateArrowImageView(opened: viewModel.opened)
    }

    private func updateArrowImageView(opened: Bool) {
        arrowImageView.rotate(opened ? .pi / 2 : 0)
    }

    // MARK: - Selector

    @objc func tapGestureAction() {
        guard let viewModel = viewModel else { return }
        delegate?.collapsibleHeaderView(sectionHeaderView: self, sectionToggled: viewModel.section)
    }

}

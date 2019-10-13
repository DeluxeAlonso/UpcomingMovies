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
    
    weak var delegate: CollapsibleHeaderViewViewDelegate?
    
    var viewModel: CollapsibleHeaderViewModel? {
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
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGray6
        }
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
        updateArrowImageView(opened: viewModel.opened, animated: false)
    }
    
    func updateArrowImageView(opened: Bool, animated: Bool) {
        let animationDuration = animated ? 0.3 : 0.0
        arrowImageView.rotate(opened ? .pi / 2 : 0, duration: animationDuration)
    }
    
    // MARK: - Selector
    
    @objc func tapGestureAction() {
        guard let viewModel = viewModel else { return }
        delegate?.collapsibleHeaderView(sectionHeaderView: self, sectionToggled: viewModel.section)
    }

}

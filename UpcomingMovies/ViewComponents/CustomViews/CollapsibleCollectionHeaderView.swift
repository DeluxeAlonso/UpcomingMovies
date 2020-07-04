//
//  CollapsibleHeaderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/14/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol CollapsibleHeaderViewDelegate: class {
    
    func collapsibleHeaderView(sectionHeaderView: CollapsibleCollectionHeaderView, sectionToggled section: Int)
    
}

final class CollapsibleHeaderViewModel {
    
    var opened: Bool
    var section: Int
    var title: String
    var shouldAnimate: Bool
    
    init(opened: Bool, section: Int, title: String, shouldAnimate: Bool = false) {
        self.opened = opened
        self.section = section
        self.title = title
        self.shouldAnimate = shouldAnimate
    }
    
}

class CollapsibleCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    weak var delegate: CollapsibleHeaderViewDelegate?
    
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
        guard let viewModel = viewModel else { return }
        accessibilityLabel = viewModel.title
        titleLabel.text = viewModel.title
    }
    
    func updateArrowImageView(animated: Bool) {
        guard let viewModel = viewModel else { return }
        let animationDuration = animated ? 0.3 : 0.0
        arrowImageView.rotate(viewModel.opened ? .pi / 2 : 0, duration: animationDuration)
    }
    
    // MARK: - Selector
    
    @objc func tapGestureAction() {
        guard let viewModel = viewModel else { return }
        delegate?.collapsibleHeaderView(sectionHeaderView: self, sectionToggled: viewModel.section)
    }

}

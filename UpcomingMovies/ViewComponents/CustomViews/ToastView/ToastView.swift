//
//  ToastView.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

class ToastView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontHelper.subheadLight
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let configuration: ToastConfigurationProtocol

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    // MARK: - Initializers

    init(configuration: ToastConfigurationProtocol) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupUI() {
        backgroundColor = configuration.backgroundColor

        layer.borderWidth = configuration.borderWidth
        layer.borderColor = configuration.borderColor.cgColor
        layer.cornerRadius = configuration.cornerRadius

        setupLabels()
    }

    private func setupLabels() {
        titleLabel.textColor = configuration.titleTextColor
        titleLabel.textAlignment = configuration.titleTextAlignment

        addSubview(titleLabel)
        let titleInsets = configuration.titleInsets
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: titleInsets.top),
             titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleInsets.left),
             titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -titleInsets.right),
             titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleInsets.bottom)])
    }

}

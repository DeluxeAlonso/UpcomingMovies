//
//  ToastView.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

class ToastView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = FontHelper.Default.mediumLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let configuration: ToastConfiguration

    // MARK: - Initializers

    init(configuration: ToastConfiguration) {
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
        layer.cornerRadius = configuration.cornerRadius

        setupLabels()
    }

    private func setupLabels() {
        titleLabel.tintColor = configuration.tintColor
        titleLabel.textColor = configuration.tintColor

        addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                     titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)])
    }

}

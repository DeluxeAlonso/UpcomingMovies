//
//  MovieDetailOptionView.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieDetailOptionView: UIView {

    private lazy var optionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 3.0
        return stackView
    }()

    private lazy var optionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var optionTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = FontHelper.callout
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    private(set) var option: MovieDetailOption

    // MARK: - Initializers

    init(option: MovieDetailOption) {
        self.option = option
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        backgroundColor = ColorPalette.navigationBarBackgroundColor

        isAccessibilityElement = true
        accessibilityLabel = option.title

        optionTitleLabel.text = option.title
        optionImageView.image = UIImage(named: option.iconName)

        setupStackView()
    }

    private func setupStackView() {
        addSubview(optionStackView)
        optionStackView.fillSuperview(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))

        optionStackView.addArrangedSubview(optionImageView)
        optionStackView.addArrangedSubview(optionTitleLabel)
    }

}

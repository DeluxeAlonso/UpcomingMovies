//
//  MovieDetailOptionView.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieDetailOptionView: UIView {
    
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
        label.font = FontHelper.regular(withSize: 16.0)
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var option: MovieDetailOption
    
    var identifier: String? {
        return option.identifier
    }
    
    // MARK: - Initializers
    
    init(option: MovieDetailOption) {
        self.option = option
        super.init(frame: .zero)
        optionTitleLabel.text = self.option.title
        optionImageView.image = self.option.icon
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
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }

    // MARK: - Private
    
    private func setupUI() {
        backgroundColor = ColorPalette.navigationBarBackgroundColor
        setupStackView()
    }
    
    private func setupStackView() {
        addSubview(optionStackView)
        optionStackView.fillSuperview(padding: .init(top: 8, left: 8,
                                                     bottom: 8, right: 8))
        
        optionStackView.addArrangedSubview(optionImageView)
        optionStackView.addArrangedSubview(optionTitleLabel)
    }
    
}

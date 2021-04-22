//
//  ErrorPlaceholderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

protocol ErrorPlaceholderViewDelegate: class {
    
    func errorPlaceholderView(_ errorPlaceholderView: ErrorPlaceholderView, didRetry sender: UIButton)
    
}

class ErrorPlaceholderView: UIView, NibLoadable, RetryPlaceHolderable {
    
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorDetailLabel: UILabel!
    @IBOutlet weak var retryButton: ShrinkingButton!
    
    var isPresented: Bool = false
    var retry: (() -> Void)?
    
    weak var delegate: ErrorPlaceholderViewDelegate?
    
    var detailText: String? {
        didSet {
            guard let detailText = detailText else { return }
            errorDetailLabel.text = detailText
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        alpha = 0.0
        setupErrorTitleLabel()
        setupErrorDetailLabel()
        setupRetryButton()
    }
    
    private func setupErrorTitleLabel() {
        errorTitleLabel.text = Constants.errorTitle
        errorTitleLabel.textColor = ColorPalette.darkGrayColor
        errorTitleLabel.font = FontHelper.regular(withSize: 24.0)
    }
    
    private func setupErrorDetailLabel() {
        errorDetailLabel.text = Constants.errorDetail
        errorDetailLabel.textColor = ColorPalette.lightGrayColor
        errorDetailLabel.font = FontHelper.light(withSize: 15.0)
    }
    
    private func setupRetryButton() {
        retryButton.setTitle(Constants.retryButtonTitle, for: .normal)
        retryButton.backgroundColor = ColorPalette.lightBlueColor
        retryButton.setTitleColor(ColorPalette.whiteColor, for: .normal)
        retryButton.setTitleColor(ColorPalette.whiteColor.withAlphaComponent(0.5), for: .highlighted)
        retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc private func retryAction() {
        retryButton.startAnimation()
        retry?()
    }
    
    // MARK: - RetryPlaceHolderable
    
    func resetState() {
        retryButton.stopAnimation()
    }
    
}

// MARK: - Constants

extension ErrorPlaceholderView {
    
    struct Constants {
        static let errorTitle = "¡Ups!"
        static let errorDetail = "Something went wrong."
        static let retryButtonTitle = "Retry"
    }
    
}

//
//  EmptyPlaceholderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class EmptyPlaceholderView: UIView, NibLoadable, Placeholderable {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!

    var isPresented: Bool = false

    var detailText: String? {
        didSet {
            guard let detailText = detailText else { return }
            messageLabel.text = detailText
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        imageView.image = #imageLiteral(resourceName: "EmptyPlaceholder")
        messageLabel.font = FontHelper.bodySemiBold
        messageLabel.textColor = ColorPalette.lightBlueColor
        messageLabel.adjustsFontForContentSizeCategory = true
    }

}

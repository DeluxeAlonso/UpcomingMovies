//
//  DefaultHudConfiguration.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/11/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

class DefaultHudConfiguration: HudConfigurationProtocol {

    static let shared = DefaultHudConfiguration()

    init() {}

    var backgroundColor: UIColor = .clear

    var hudColor: UIColor = UIColor(white: 0.8, alpha: 0.36)

    var activityIndicatorColor: UIColor = UIColor.lightGray

    var textColor: UIColor = UIColor.black

    var textFont: UIFont = UIFont.boldSystemFont(ofSize: 24)

    var preferredHudContentWidth: CGFloat = 120.0

    var preferredHudContentHeight: CGFloat = 120.0

    var hudContentCornerRadius: CGFloat = 10.0

    var presentationAnimationDuration: CGFloat = 0.5

}

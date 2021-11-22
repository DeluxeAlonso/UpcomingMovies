//
//  HudConfigurationProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/11/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

protocol HudConfigurationProtocol {

    var backgroundColor: UIColor { get }
    var hudColor: UIColor { get }
    var activityIndicatorColor: UIColor { get }

    var textColor: UIColor { get }
    var textFont: UIFont { get }

    var hudContentPreferredWidth: CGFloat { get }
    var hudContentPreferredHeight: CGFloat { get }

    var hudContentCornerRadius: CGFloat { get }

    var presentationAnimationDuration: CGFloat { get }

}

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

    var backgroundColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)

    var hudColor: UIColor = UIColor.systemBlue

    var activityIndicatorColor: UIColor = UIColor.lightGray

    var textColor: UIColor = UIColor.black

    var textFont: UIFont = UIFont.boldSystemFont(ofSize: 24)

}

//
//  ToastSuccessConfiguration.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

class ToastSuccessConfiguration: ToastConfigurationProtocol {

    static let shared = ToastSuccessConfiguration()

    init() {}

    var backgroundColor: UIColor = .black
    var borderColor: UIColor = .lightGray
    var borderWidth: CGFloat = 1.0

    var titleInsets: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    var titleTextColor: UIColor = .white
    var titleTextAlignment: NSTextAlignment = .center

    var cornerRadius: CGFloat = 5.0
    var animationDuration: TimeInterval = 0.5

    var dismissDuration: TimeInterval = 3.0

}

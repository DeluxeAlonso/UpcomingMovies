//
//  ToastSuccessConfiguration.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

final class ToastSuccessConfiguration: ToastConfigurationProtocol {

    init() {}

    let backgroundColor: UIColor = .black
    let borderColor: UIColor = .lightGray
    let borderWidth: CGFloat = 1.0

    let titleInsets: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    let titleTextColor: UIColor = .white
    let titleTextAlignment: NSTextAlignment = .center

    let cornerRadius: CGFloat = 5.0
    let animationDuration: TimeInterval = 0.5

    let dismissDuration: TimeInterval = 3.0

}

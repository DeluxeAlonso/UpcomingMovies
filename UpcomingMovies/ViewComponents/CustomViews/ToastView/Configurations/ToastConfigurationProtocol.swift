//
//  ToastConfigurationProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

protocol ToastConfigurationProtocol {

    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }

    var titleInsets: UIEdgeInsets { get }
    var titleTextColor: UIColor { get }
    var titleTextAlignment: NSTextAlignment { get }

    var cornerRadius: CGFloat { get }
    var animationDuration: TimeInterval { get }

    var dismissDuration: TimeInterval { get }

}

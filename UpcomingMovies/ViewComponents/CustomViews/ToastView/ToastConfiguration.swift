//
//  ToastConfiguration.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

protocol ToastConfiguration {

    var backgroundColor: UIColor { get }
    var titleInsets: UIEdgeInsets { get }
    var titleTextColor: UIColor { get }
    var titleTextAlignment: NSTextAlignment { get }
    var cornerRadius: CGFloat { get }
    var animationDuration: TimeInterval { get }

}

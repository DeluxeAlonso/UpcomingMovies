//
//  ErrorDisplayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

protocol ErrorDisplayable {
    
    static func show<T: ErrorPlaceholderView>(
        fromViewController viewController: UIViewController,
        animated: Bool,
        completion: ((Bool) -> Swift.Void)?) -> T
    
    static func show<T: ErrorPlaceholderView>(
        fromView view: UIView,
        insets: UIEdgeInsets, animated: Bool,
        completion: ((Bool) -> Swift.Void)?) -> T
    
    func hide(animated: Bool, completion: ((Bool) -> Swift.Void)?)
    
}

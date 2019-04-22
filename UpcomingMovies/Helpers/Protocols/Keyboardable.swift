//
//  Keyboardable.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/22/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol Keyboardable {}

extension Keyboardable where Self: UIViewController {
    
    func registerKeyboardWillShowNotification(using block: ((CGRect) -> Void)? = nil) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil, queue: nil,
                                               using: { (notification) -> Void in
            guard let keyboardFrame: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            block?(keyboardFrame)
        })
    }
    
    func registerKeyboardWillHideNotification(using block: (() -> Void)? = nil) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil, queue: nil,
                                               using: { _ -> Void in
            block?()
        })
    }
    
}

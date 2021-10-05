//
//  UIView+ToastUtils.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

extension UIView {

    func showSuccessToast(withMessage message: String, completion: ((Bool) -> Void)? = nil) {
        showToast(withMessage: message, defaultConfiguration: .success, completion: completion)
    }

    func showFailureToast(withMessage message: String, completion: ((Bool) -> Void)? = nil) {
        showToast(withMessage: message, defaultConfiguration: .failure, completion: completion)
    }

}

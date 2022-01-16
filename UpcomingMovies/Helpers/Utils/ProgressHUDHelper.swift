//
//  ProgressHUDHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation
import DLProgressHUD

protocol ProgressHUDHelperProtocol {

    func showHUDWithOnlyText(_ text: String)

}

class ProgressHUDHelper: ProgressHUDHelperProtocol {

    func showHUDWithOnlyText(_ text: String) {
        DLProgressHUD.defaultConfiguration.allowsDynamicTextWidth = true
        DLProgressHUD.defaultConfiguration.shouldDismissAutomatically = true
        DLProgressHUD.show(.textOnly(text))
    }

}

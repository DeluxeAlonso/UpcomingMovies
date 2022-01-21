//
//  ProgressHUDAdapter.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import DLProgressHUD

final class ProgressHUDAdapter: ProgressHUDAdapterProtocol {

    func showHUDWithOnlyText(_ text: String) {
        DLProgressHUD.defaultConfiguration.allowsDynamicTextWidth = true
        DLProgressHUD.defaultConfiguration.shouldDismissAutomatically = true
        DLProgressHUD.defaultConfiguration.hudContentPreferredHeight = 64.0
        DLProgressHUD.show(.textOnly(text))
    }

}

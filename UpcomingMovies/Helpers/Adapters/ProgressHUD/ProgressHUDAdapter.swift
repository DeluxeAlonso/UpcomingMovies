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
        configureHUDWithOnlyText()
        DLProgressHUD.show(.textOnly(text))
    }

    func showHUDWithOnlyText(_ text: String, in view: UIView) {
        configureHUDWithOnlyText()
        DLProgressHUD.show(.textOnly(text), in: view)
    }

    private func configureHUDWithOnlyText() {
        DLProgressHUD.defaultConfiguration.allowsDynamicTextWidth = true
        DLProgressHUD.defaultConfiguration.shouldDismissAutomatically = true
        DLProgressHUD.defaultConfiguration.backgroundInteractionEnabled = true
        DLProgressHUD.defaultConfiguration.hudContentPreferredHeight = 64.0
    }

}

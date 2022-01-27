//
//  MovieDetailUIHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import UIKit

final class MovieDetailUIHelper: MovieDetailUIHelperProtocol, LoadingDisplayable {

    private let progressHUDAdapter: ProgressHUDAdapterProtocol

    // MARK: - LoadingDisplayable

    var loaderView: LoadingView = RadarView()

    // MARK: - Initializers

    init(progressHUDAdapter: ProgressHUDAdapterProtocol) {
        self.progressHUDAdapter = progressHUDAdapter
    }

    // MARK: - MovieDetailUIHelperProtocol

    func showHUD(with text: String) {
        progressHUDAdapter.showHUDWithOnlyText(text)
    }

    func showFullscreenLoader(in view: UIView) {
        showLoader(in: view)
    }

    func dismissFullscreenLoader() {
        hideLoader()
    }

}

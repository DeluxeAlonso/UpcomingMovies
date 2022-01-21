//
//  MovieDetailUIHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

final class MovieDetailUIHelper: MovieDetailUIHelperProtocol {

    private let progressHUDAdapter: ProgressHUDAdapterProtocol

    init(progressHUDAdapter: ProgressHUDAdapterProtocol) {
        self.progressHUDAdapter = progressHUDAdapter
    }

    func showHUD(with text: String) {
        progressHUDAdapter.showHUDWithOnlyText(text)
    }

}

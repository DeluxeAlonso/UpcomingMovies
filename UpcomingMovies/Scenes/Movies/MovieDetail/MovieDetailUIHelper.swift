//
//  MovieDetailUIHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

final class MovieDetailUIHelper: MovieDetailUIHelperProtocol {

    private let progressHUDHelper: ProgressHUDHelperProtocol

    init(progressHUDHelper: ProgressHUDHelperProtocol) {
        self.progressHUDHelper = progressHUDHelper
    }

    func showHUD(with text: String) {
        progressHUDHelper.showHUDWithOnlyText(text)
    }

}

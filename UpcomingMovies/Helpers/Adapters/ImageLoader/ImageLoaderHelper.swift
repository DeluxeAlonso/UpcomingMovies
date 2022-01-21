//
//  ImageLoaderHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

final class ImageLoaderHelper: ImageLoaderAdapterProtocol {

    func loadURL(_ url: URL?, on imageView: UIImageView) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }

    func cancelImageLoading(on imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }

}

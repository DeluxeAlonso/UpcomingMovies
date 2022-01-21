//
//  ImageLoaderAdapterProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 20/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import UIKit

protocol ImageLoaderAdapterProtocol {

    func loadURL(_ url: URL?, on imageView: UIImageView)
    func cancelImageLoading(on imageView: UIImageView)

}

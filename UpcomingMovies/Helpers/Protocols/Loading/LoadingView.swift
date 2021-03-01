//
//  LoadingView.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/28/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

protocol LoadingView: Displayable {

    func startLoading()
    func stopLoading()

}

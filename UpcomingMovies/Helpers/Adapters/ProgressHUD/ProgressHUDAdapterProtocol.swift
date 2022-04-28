//
//  ProgressHUDAdapterProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import UIKit

protocol ProgressHUDAdapterProtocol {

    func showHUDWithOnlyText(_ text: String)
    func showHUDWithOnlyText(_ text: String, in view: UIView)

}

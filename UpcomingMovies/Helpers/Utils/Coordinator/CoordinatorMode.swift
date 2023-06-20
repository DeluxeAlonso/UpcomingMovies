//
//  CoordinatorMode.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

public enum CoordinatorMode {
    case push
    case present(presentingViewController: UIViewController)
    case embed(parentViewController: UIViewController, containerView: UIView?)
}

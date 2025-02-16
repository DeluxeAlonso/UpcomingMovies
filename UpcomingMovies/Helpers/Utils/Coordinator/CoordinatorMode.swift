//
//  CoordinatorMode.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

enum CoordinatorMode {
    case push
    case present(presentingViewController: UIViewController, configuration: CoordinatorModePresentConfiguration?)
    case embed(parentViewController: UIViewController, containerView: UIView?)
}

struct CoordinatorModePresentConfiguration {
    let modalPresentationStyle: UIModalPresentationStyle
    let transitioningDelegate: UIViewControllerTransitioningDelegate?
}

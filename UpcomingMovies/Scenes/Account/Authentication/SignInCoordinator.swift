//
//  SignInCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

final class SignInCoordinator: BaseCoordinatorV2, SignInCoordinatorProtocol {

    private weak var delegate: SignInViewControllerDelegate?

    init(navigationController: UINavigationController, delegate: SignInViewControllerDelegate?) {
        self.delegate = delegate
        super.init(navigationController: navigationController)
    }

    override func build() -> SignInViewController {
        let viewController = SignInViewController.instantiate()
        viewController.delegate = delegate
        return viewController
    }

}

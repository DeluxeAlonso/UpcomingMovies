//
//  MockNavigationController.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

final class MockNavigationController: UINavigationController {

    var pushViewControllerCallCount = 0
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCallCount += 1
    }

    var presentCallCount = 0
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCallCount += 1
    }
}

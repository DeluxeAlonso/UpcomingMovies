//
//  MockViewController.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 4/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

class MockViewController: UIViewController {

    var addChildCallCount = 0
    override func addChild(_ childController: UIViewController) {
        addChildCallCount += 1
    }

    var presentCount = 0
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCount += 1
    }

    var dismissCount = 0
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCount += 1
        if let completion {
            completion()
        }
    }

}

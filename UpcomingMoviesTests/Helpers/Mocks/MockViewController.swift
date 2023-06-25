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

    var removeFromParentCallCount = 0
    override func removeFromParent() {
        removeFromParentCallCount += 1
    }

    var presentCallCount = 0
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCallCount += 1
    }

    var dismissCallCount = 0
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCallCount += 1
        if let completion {
            completion()
        }
    }

}

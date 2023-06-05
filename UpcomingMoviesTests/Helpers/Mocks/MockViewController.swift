//
//  MockViewController.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 4/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

final class MockViewController: UIViewController {

    var addChildCallCount = 0
    override func addChild(_ childController: UIViewController) {
        addChildCallCount += 1
    }

}

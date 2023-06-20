//
//  MockCoordinator.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 20/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit
@testable import UpcomingMovies

final class MockCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController = MockNavigationController()

    var shouldBeAutomaticallyFinished: Bool = false

    private(set) var startCallCount = 0
    func start() {
        startCallCount += 1
    }

    private(set) var childDidFinishChildCoordinatorCallCount = 0
    func childDidFinish(_ child: Coordinator) {
        childDidFinishChildCoordinatorCallCount += 1
    }

    private(set) var childDidFinishCallCount = 0
    func childDidFinish() {
        childDidFinishCallCount += 1
    }

    private(set) var childDidFinishV2CallCount = 0
    func childDidFinishV2() {
        childDidFinishV2CallCount += 1
    }

}

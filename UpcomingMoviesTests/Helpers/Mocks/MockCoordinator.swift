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

    func start() {}

}

//
//  CustomListsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

final class CustomListsCoordinator: BaseCoordinator, CustomListsCoordinatorProtocol {

    override func start() {
        let viewController = CustomListsViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve()
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

    func showListDetail(for customList: ListProtocol) {
        let coordinator = CustomListDetailCoordinator(navigationController: navigationController, customList: customList)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}

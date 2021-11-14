//
//  UIViewControllerHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

extension UIViewController {

    func add(asChildViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }

        addChild(viewController)

        view.addSubview(viewController.view)

        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }

    func add(asChildViewController viewController: UIViewController?, containerView: UIView) {
        guard let viewController = viewController, containerView.isDescendant(of: view) else {
            return
        }

        addChild(viewController)

        containerView.addSubview(viewController.view)

        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }

    func remove(asChildViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    // MARK: - Navigation Controller

    func setTitleAnimated(_ title: String?,
                          with transitionType: CATransitionType = .fade,
                          animated: Bool = false) {
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = animated ? 0.5 : 0.0
        fadeTextAnimation.type = transitionType

        navigationController?.navigationBar.layer.add(fadeTextAnimation,
                                                      forKey: "animateText")
        navigationItem.title = title
    }

    // MARK: - Action sheets

    func showSimpleActionSheet(title: String?, message: String?, action: UIAlertAction) {
        let actionSheet = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .actionSheet)

        let cancelTitle = LocalizedStrings.cancel()
        let cancelActionButton = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        actionSheet.addAction(cancelActionButton)

        actionSheet.addAction(action)
        present(actionSheet, animated: true, completion: nil)
    }

    // MARK: - Navigation Bar

    func setClearAppearanceNavigationBar() {
        if #available(iOS 15, *) {
            // It is recommended by apple to set the appearance for the navigation
            // item when configuring the navigation appearance of a specific view controller
            // https://developer.apple.com/forums/thread/683590
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationItem.standardAppearance = navigationBarAppearance
            navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }

    func setDefaultAppearanceNavigationBar(with barTintColor: UIColor) {
        if #available(iOS 15, *) {
            // It is recommended by apple to set the appearance for the navigation
            // item when configuring the navigation appearance of a specific view controller
            // https://developer.apple.com/forums/thread/683590
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            navigationItem.standardAppearance = navigationBarAppearance
            navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.barTintColor = barTintColor
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
    }

    var navigationBarHeight: CGFloat {
        guard let navigationController = navigationController else { return 0 }

        let top = navigationController.navigationBar.intrinsicContentSize.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight =  top + statusBarHeight

        return navBarHeight
    }

    // MARK: - Deep Link Handling

    func openDeepLinkURL(_ url: URL?) {
        let application = UIApplication.shared
        guard let url = url, application.canOpenURL(url) else { return }
        application.open(url, options: [:], completionHandler: nil)
    }

}

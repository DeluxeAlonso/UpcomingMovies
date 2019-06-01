//
//  UIViewControllerHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return delegate
    }
    
    func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        
        view.addSubview(viewController.view)
        
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    // MARK: - Navigation Controller
    
    func setTitleAnimated(_ title: String?,
                          with transitionType: CATransitionType = .fade) {
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.5
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
        
        let cancelTitle = "Cancel"
        let cancelActionButton = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        actionSheet.addAction(cancelActionButton)
        
        actionSheet.addAction(action)
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Navigation Bar
    
    func setClearNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func restoreClearNavigationBar(with barTintColor: UIColor) {
        navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    var navigationBarHeight: CGFloat {
        guard let navigationController = navigationController else { return 0 }
        
        let top = navigationController.navigationBar.intrinsicContentSize.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight =  top + statusBarHeight
        
        return navBarHeight
    }
    
}

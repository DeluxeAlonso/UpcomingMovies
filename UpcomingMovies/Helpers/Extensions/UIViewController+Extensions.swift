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
    
}

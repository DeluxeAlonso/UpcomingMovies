//
//  LoaderDisplayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol LoadingDisplayable: class {

    var loaderView: LoadingView? { get }

    func showLoader()
    func hideLoader()

}

extension LoadingDisplayable where Self: UIViewController {

    // MARK: - Show loader

    func showLoader() {
        DispatchQueue.main.async {
            self.loaderView?.show(in: self.view, animated: false, completion: nil)
            self.loaderView?.startLoading()
        }
    }

    // MARK: - Hiding loader

    func hideLoader() {
        DispatchQueue.main.async {
            self.loaderView?.hide(animated: true, completion: { _ in
                self.loaderView?.stopLoading()
            })
        }
    }

}

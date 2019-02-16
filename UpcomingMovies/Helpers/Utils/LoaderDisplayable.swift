//
//  LoaderDisplayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var loaderView: UIView = UIView()
}

protocol LoaderDisplayable: class {
    
    associatedtype ViewType: UIView
    
    var loaderView: ViewType! { get set }
    
    func showLoader()
    func hideLoader()
    
}

extension LoaderDisplayable where Self: UIViewController {
    
    func showLoader() {
        DispatchQueue.main.async {
            self.loaderView = ViewType()
            self.loaderView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.loaderView.center = self.view.center
            self.view.addSubview(self.loaderView)
            self.view.bringSubviewToFront(self.loaderView)
        }
        
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.loaderView.removeFromSuperview()
        }
    }
    
}

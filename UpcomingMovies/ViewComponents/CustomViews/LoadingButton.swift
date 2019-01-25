//
//  LoadingButton.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class LoadingButton: UIButton {
    
    @IBInspectable var indicatorColor: UIColor = .white
    
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    func showLoading() {
        self.isUserInteractionEnabled = false
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        self.setImage(nil, for: .normal)
        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
        }
        showActivityIndicator()
    }
    
    func hideLoading() {
        guard let activityIndicator = activityIndicator else { return }
        self.isUserInteractionEnabled = true
        DispatchQueue.main.async(execute: {
            self.setTitle(self.originalButtonText, for: .normal)
            activityIndicator.stopAnimating()
        })
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = indicatorColor
        return activityIndicator
    }
    
    private func showActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}

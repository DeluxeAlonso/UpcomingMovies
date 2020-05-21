//
//  EmptyPlaceholderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class EmptyPlaceholderView: UIView, NibLoadable, Placeholderable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var animationDuration = 0.3
    var isPresented: Bool = false
    var retry: (() -> Void)?
    
    var messageText: String? {
        didSet {
            guard let messageText = messageText else { return }
            messageLabel.text = messageText
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        imageView.image = #imageLiteral(resourceName: "EmptyPlaceholder")
        messageLabel.font = FontHelper.regular(withSize: 18.0)
        messageLabel.textColor = ColorPalette.lightBlueColor
    }

}

// MARK: - EmptyDisplayable

extension EmptyPlaceholderView {
    
    static func show<T: EmptyPlaceholderView>(
        fromViewController viewController: UIViewController,
        animated: Bool = true,
        completion: ((Bool) -> Swift.Void)? = nil) -> T {
        
        guard let subview = loadFromNib() as? T else {
            fatalError("The subview is expected to be of type \(T.self)")
        }
        
        viewController.view.addSubview(subview)
        
        // Configure constraints if needed
        
        subview.alpha = 0
        subview.isPresented = true
        subview.superview?.sendSubviewToBack(subview)
        subview.show(animated: animated) { _ in
        }
        return subview
    }
    
}

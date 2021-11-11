//
//  Dequeueable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/12/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol Dequeueable {

    static var dequeueIdentifier: String { get }

}

extension Dequeueable where Self: UIView {

    static var dequeueIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: Dequeueable { }

extension UICollectionViewCell: Dequeueable { }

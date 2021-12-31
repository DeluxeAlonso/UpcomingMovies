//
//  ImageTransitionable.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/30/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol Transitionable: UIViewController {

    var transitionContainerView: UIView! { get }

}

protocol TransitionableInitiator: UIViewController {}

//
//  Utils.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/28/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

func degreesToRadians (_ value: CGFloat) -> CGFloat {

    let piDegrees: CGFloat = 180.0
    return (value * CGFloat.pi) / piDegrees

}

func radiansToDegrees (_ value: CGFloat) -> CGFloat {

    let piDegrees: CGFloat = 180.0
    return (value * piDegrees) / CGFloat.pi

}

//
//  FontHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

struct FontHelper {

    static func bold(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
    }

    static func semiBold(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
    }

    static func light(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
    }

    static func regular(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }

}

extension FontHelper {

    static let headline = FontHelper.semiBold(withSize: 21.0)
    static let headlineBold = FontHelper.bold(withSize: 21.0)

    static let body = FontHelper.regular(withSize: 17.0)
    static let bodySemiBold = FontHelper.semiBold(withSize: 17.0)
    static let bodyBold = FontHelper.bold(withSize: 17.0)

    static let callout = FontHelper.regular(withSize: 16.0)
    static let calloutLight = FontHelper.light(withSize: 16.0)
    static let calloutSemiBold = FontHelper.semiBold(withSize: 16.0)

    static let subhead = FontHelper.regular(withSize: 15.0)
    static let subheadLight = FontHelper.light(withSize: 15.0)
    static let subheadBold = FontHelper.bold(withSize: 15.0)

    static let footnote = FontHelper.regular(withSize: 13.0)
    static let footnoteLight = FontHelper.light(withSize: 13.0)

    static let caption1 = FontHelper.regular(withSize: 12.0)
    static let caption1Light = FontHelper.light(withSize: 12.0)
    static let caption2 = FontHelper.regular(withSize: 11.0)

}

//
//  FontHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

struct FontHelper {

    enum FontSize: CGFloat {
        case small = 14
        case medium = 15
        case big = 16
    }

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

    struct Default {

        static let headline = FontHelper.semiBold(withSize: 21.0)
        static let body = FontHelper.regular(withSize: 17.0)
        static let callout = FontHelper.regular(withSize: 16.0)

        static let subhead = FontHelper.regular(withSize: 15.0)
        static let subheadLight = FontHelper.light(withSize: 15.0)

        static let footnote = FontHelper.regular(withSize: 13.0)
        static let caption1 = FontHelper.regular(withSize: 12.0)
        static let caption2 = FontHelper.regular(withSize: 11.0)

//        static let smallLight = FontHelper.light(withSize: FontSize.small.rawValue)
//        static let smallBold = FontHelper.bold(withSize: FontSize.small.rawValue)
//
//        static let mediumLight = FontHelper.light(withSize: FontSize.medium.rawValue)
//        static let mediumBold = FontHelper.bold(withSize: FontSize.medium.rawValue)
//
//        static let bigLight = FontHelper.light(withSize: FontSize.big.rawValue)
//        static let bigBold = FontHelper.bold(withSize: FontSize.big.rawValue)

    }

}

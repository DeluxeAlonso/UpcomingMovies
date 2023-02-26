//
//  ColorPalette.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(withIntRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let maxColorValue: CGFloat = 255

        let floatRed = red / maxColorValue
        let floatGreen = green / maxColorValue
        let floatBlue = blue / maxColorValue

        self.init(red: floatRed, green: floatGreen, blue: floatBlue, alpha: alpha)
    }

}

struct ColorPalette {

    static let lightBlueColor = UIColor(withIntRed: 74, green: 144, blue: 226, alpha: 1)
    static let darkBlueColor = UIColor(withIntRed: 0, green: 101, blue: 163, alpha: 1)
    static let lightGrayColor = UIColor(withIntRed: 205, green: 205, blue: 205, alpha: 1)
    static let redColor = UIColor(withIntRed: 255, green: 94, blue: 112, alpha: 1)
    static let grayColor = UIColor(withIntRed: 130, green: 130, blue: 130, alpha: 1)
    static let whiteColor = UIColor(white: 249 / 255, alpha: 1)
    static let blackColor = UIColor(white: 40 / 255, alpha: 1)
    static let darkGrayColor = UIColor.darkGray
    static let regularGray = UIColor.systemGray

    static var defaultBackgroundColor: UIColor {
        UIColor.systemBackground
    }

    static var defaultGrayBackgroundColor: UIColor {
        UIColor.systemGray6
    }

    static var navigationBarBackgroundColor: UIColor {
        UIColor.systemBackground
    }

    static var groupedCellBackgroundColor: UIColor {
        UIColor.secondarySystemGroupedBackground
    }

    struct Label {
        static var defaultColor: UIColor {
            UIColor.label
        }
    }

}

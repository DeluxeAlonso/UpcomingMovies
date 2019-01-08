//
//  ColorPalette.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(withIntRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        
        let floatRed = CGFloat(red)/255
        let floatGreen = CGFloat(green)/255
        let floatBlue = CGFloat(blue)/255
        
        self.init(red: floatRed, green: floatGreen, blue: floatBlue, alpha: alpha)
    }
    
}

struct ColorPalette {
    
    struct Constant {
        static let blackText: CGFloat = 40
        static let whiteText: CGFloat = 249
    }
    
    static let lightBlueColor = UIColor(withIntRed: 74, green: 144, blue: 226, alpha: 1)
    static let lightGrayColor = UIColor(withIntRed: 205, green: 205, blue: 205, alpha: 1)
    static let redColor = UIColor(withIntRed: 255, green: 94, blue: 112, alpha: 1)
    
    static let whiteColor = UIColor(white: Constant.whiteText / 255, alpha: 1)
    static let grayColor = UIColor(withIntRed: 130, green: 130, blue: 130, alpha: 1)
    static let blackColor = UIColor(white: Constant.blackText / 255, alpha: 1)
    
    static let darkGray = UIColor.darkGray
    static let lightGray = UIColor.lightGray
    static let lighterGray = UIColor(withIntRed: 223, green: 223, blue: 223, alpha: 1)
}

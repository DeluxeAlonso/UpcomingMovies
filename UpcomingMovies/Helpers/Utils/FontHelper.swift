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
        
        static let smallLight = FontHelper.light(withSize: FontSize.small.rawValue)
        static let smallBold = FontHelper.bold(withSize: FontSize.small.rawValue)

        static let mediumLight = FontHelper.light(withSize: FontSize.medium.rawValue)
        static let mediumBold = FontHelper.bold(withSize: FontSize.medium.rawValue)
        
        static let bigLight = FontHelper.light(withSize: FontSize.big.rawValue)
        static let bigBold = FontHelper.bold(withSize: FontSize.big.rawValue)
        
    }
    
}

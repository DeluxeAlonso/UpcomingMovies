//
//  CGRect+Extensions.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

extension CGRect {

    var xPos: CGFloat {
        get {
            self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.yPos, width: self.width, height: self.height)
        }
    }

    var yPos: CGFloat {
        get {
            self.origin.y
        }
        set {
            self = CGRect(x: self.xPos, y: newValue, width: self.width, height: self.height)
        }
    }

    var width: CGFloat {
        get {
            self.size.width
        }
        set {
            self = CGRect(x: self.xPos, y: self.yPos, width: newValue, height: self.height)
        }
    }

    var height: CGFloat {
        get {
            self.size.height
        }
        set {
            self = CGRect(x: self.xPos, y: self.yPos, width: self.width, height: newValue)
        }
    }

    var top: CGFloat {
        get {
            self.origin.y
        }
        set {
            yPos = newValue
        }
    }

    var bottom: CGFloat {
        get {
            self.origin.y + self.size.height
        }
        set {
            self = CGRect(x: xPos, y: newValue - height, width: width, height: height)
        }
    }

    var left: CGFloat {
        get {
            self.origin.x
        }
        set {
            self.xPos = newValue
        }
    }

    var right: CGFloat {
        get {
            xPos + width
        }
        set {
            self = CGRect(x: newValue - width, y: yPos, width: width, height: height)
        }
    }

    var midX: CGFloat {
        get {
            self.xPos + self.width / 2
        }
        set {
            self = CGRect(x: newValue - width / 2, y: yPos, width: width, height: height)
        }
    }

    var midY: CGFloat {
        get {
            self.yPos + self.height / 2
        }
        set {
            self = CGRect(x: xPos, y: newValue - height / 2, width: width, height: height)
        }
    }

    var center: CGPoint {
        get {
            CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }

}

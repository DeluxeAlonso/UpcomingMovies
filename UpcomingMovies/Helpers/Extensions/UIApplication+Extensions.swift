//
//  UIApplication+Extensions.swift
//  UpcomingMovies
//
//  Created by Alonso on 21/01/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UIKit

extension UIApplication {

    var keyWindow: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }

}

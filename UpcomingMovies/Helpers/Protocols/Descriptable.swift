//
//  Descriptable.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/16/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol Descriptable {
    
    var description: String { get }
    
}

protocol ErrorDescriptable: Descriptable {}

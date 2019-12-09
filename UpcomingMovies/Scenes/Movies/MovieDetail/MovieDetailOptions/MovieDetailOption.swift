//
//  MovieDetailOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol MovieDetailOption {
    
    var title: String { get }
    var icon: UIImage { get }
    var identifier: String { get }
    
}

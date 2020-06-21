//
//  MovieDetailOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol MovieDetailOption: class {
    
    var title: String { get }
    var icon: UIImage { get }
    
   func prepare(coordinator: MovieDetailCoordinator?)
    
}

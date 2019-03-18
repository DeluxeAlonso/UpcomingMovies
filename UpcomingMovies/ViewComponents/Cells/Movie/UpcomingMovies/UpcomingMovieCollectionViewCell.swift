//
//  UpcomingMovieCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol UpcomingMovieCollectionViewCell {
    
    var posterImageView: UIImageView! { get set }
    var viewModel: UpcomingMovieCellViewModel? { get set }
    
}

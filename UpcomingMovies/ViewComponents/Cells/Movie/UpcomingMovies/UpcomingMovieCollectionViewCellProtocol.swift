//
//  UpcomingMovieCollectionViewCellProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol UpcomingMovieCollectionViewCellProtocol {

    var posterImageView: UIImageView! { get }
    var viewModel: UpcomingMovieCellViewModelProtocol? { get set }

}

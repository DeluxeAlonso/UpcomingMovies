//
//  MovieReviewDetailProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

protocol MovieReviewDetailViewModelProtocol {

    var author: String { get }
    var content: String { get }

}

protocol MovieReviewDetailCoordinatorProtocol: AnyObject {

    func dismiss()

}

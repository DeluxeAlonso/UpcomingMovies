//
//  CustomListDetailHeaderViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol CustomListDetailHeaderViewModelProtocol {

    var name: String { get }
    var description: String? { get }
    var posterURL: URL? { get }

}

struct CustomListDetailHeaderViewModel: CustomListDetailHeaderViewModelProtocol {

    let name: String
    let description: String?
    let posterURL: URL?

    init(list: ListProtocol) {
        self.name = list.name
        self.description = list.description
        self.posterURL = list.backdropURL
    }

}

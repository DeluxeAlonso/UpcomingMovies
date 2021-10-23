//
//  ProfileAccountInfoCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ProfileAccountInforCellViewModelProtocol {

    var name: String { get }
    var username: String? { get }

}

final class ProfileAccountInforCellViewModel: ProfileAccountInforCellViewModelProtocol {

    let name: String
    let username: String?

    init(userAccount: User) {
        name = userAccount.name
        username = userAccount.username
    }

}

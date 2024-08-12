//
//  ProfileAccountInfoCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol ProfileAccountInfoCellViewModelProtocol {

    var name: String { get }
    var username: String { get }
    var avatarImageURL: URL? { get }

}

struct ProfileAccountInfoCellViewModel: ProfileAccountInfoCellViewModelProtocol {

    let name: String
    let username: String
    let avatarImageURL: URL?

    // MARK: - Initializers

    init(userAccount: UserProtocol) {
        self.name = userAccount.name
        self.username = userAccount.username
        self.avatarImageURL = userAccount.avatarImageURL
    }

}

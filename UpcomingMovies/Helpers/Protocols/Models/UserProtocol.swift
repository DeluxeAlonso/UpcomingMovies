//
//  UserProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 21/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol UserProtocol: ImageConfigurable {

    var id: Int { get }
    var name: String { get }
    var username: String { get }
    var includeAdult: Bool { get }
    var avatarImageURL: URL? { get }

    func hasUpdatedInfo(_ newUserInfo: UserProtocol) -> Bool

}

struct UserModel: UserProtocol {

    let id: Int
    let name: String
    let username: String
    let includeAdult: Bool

    private let avatarPath: String?

    var avatarImageURL: URL? {
        guard let avatarPath, let avatarImageBaseURLString else { return nil }
        let urlString = avatarImageBaseURLString.appending(avatarPath)
        return URL(string: urlString)
    }

    init(_ user: User) {
        self.id = user.id
        self.name = user.name
        self.username = user.username
        self.includeAdult = user.includeAdult
        self.avatarPath = user.avatarPath
    }

    func hasUpdatedInfo(_ newUserInfo: UserProtocol) -> Bool {
        self.id != newUserInfo.id ||
        self.name != newUserInfo.name ||
        self.username != newUserInfo.username ||
        self.avatarImageURL != newUserInfo.avatarImageURL
    }

}

//
//  UserProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 21/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation

protocol UserProtocol {

    var id: Int { get }
    var name: String { get }
    var username: String { get }
    var includeAdult: Bool { get }
    var avatarPath: String? { get }

}

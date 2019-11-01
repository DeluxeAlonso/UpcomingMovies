//
//  ProfileAccountInfoCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain

final class ProfileAccountInforCellViewModel {
    
    let name: String
    let username: String?
    
    init(userAccount: User) {
        name = userAccount.name
        username = userAccount.username
    }
    
}

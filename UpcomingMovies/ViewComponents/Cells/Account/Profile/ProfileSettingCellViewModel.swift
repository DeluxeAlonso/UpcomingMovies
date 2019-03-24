//
//  ProfileSettingCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class ProfileSettingCellViewModel {
    
    let title: String?
    
    init(_ profileSetting: ProfileSettingsOption) {
        self.title = profileSetting.title
    }
    
}

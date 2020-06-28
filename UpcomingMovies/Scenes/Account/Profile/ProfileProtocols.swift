//
//  ProfileProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ProfileViewStateProtocol {
    
    var sections: [ProfileSection] { get }
    
}

protocol ProfileViewModelProtocol {
    
    var userInfoCell: ProfileAccountInforCellViewModel? { get }
    var collectionOptionsCells: [ProfileSelectableOptionCellViewModel] { get }
    var groupOptionsCells: [ProfileSelectableOptionCellViewModel] { get }
    
    var viewState: Bindable<ProfileViewStateProtocol> { get set }
    var reloadAccountInfo: (() -> Void)? { get set }
    
    func collectionOption(at index: Int) -> ProfileCollectionOption
    func groupOption(at index: Int) -> ProfileGroupOption
    
    func section(at index: Int) -> ProfileSection
    
    func getAccountDetails()
    
}

protocol ProfileViewControllerDelegate: class {

    func profileViewController(didTapCollection collection: ProfileCollectionOption)
    func profileViewController(didTapGroup group: ProfileGroupOption)
    func profileViewController(didTapSignOutButton tapped: Bool)
    
}

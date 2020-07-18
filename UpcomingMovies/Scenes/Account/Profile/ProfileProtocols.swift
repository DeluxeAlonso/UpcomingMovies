//
//  ProfileProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ProfileViewModelProtocol {
    
    var userInfoCell: ProfileAccountInforCellViewModel? { get }
    var collectionOptionsCells: [ProfileSelectableOptionCellViewModel] { get }
    var groupOptionsCells: [ProfileSelectableOptionCellViewModel] { get }
    
    var viewState: Bindable<ProfileViewState> { get }
    var reloadAccountInfo: (() -> Void)? { get set }
    
    func collectionOption(at index: Int) -> ProfileCollectionOption
    func groupOption(at index: Int) -> ProfileGroupOption
    
    func section(at index: Int) -> ProfileSection
    
    func getAccountDetails()
    
}

protocol ProfileInteractorProtocol {
    
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void)
    
}

protocol ProfileViewControllerDelegate: class {

    func profileViewController(didTapCollection collection: ProfileCollectionOption)
    func profileViewController(didTapGroup group: ProfileGroupOption)
    func profileViewController(didTapSignOutButton tapped: Bool)
    
}

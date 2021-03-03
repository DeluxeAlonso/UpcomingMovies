//
//  ProfileDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class ProfileDataSource: NSObject, UITableViewDataSource {
    
    private var viewModel: ProfileViewModelProtocol?

    // MARK: - Initializers
    
    init(viewModel: ProfileViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        switch viewModel.section(at: section) {
        case .accountInfo:
            return 1
        case .collections:
            return viewModel.collectionOptionsCells.count
        case .groups:
            return viewModel.groupOptionsCells.count
        case .signOut:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        switch viewModel.section(at: indexPath.section) {
        case .accountInfo:
            let cell = tableView.dequeueReusableCell(with: ProfileAccountInfoTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.userInfoCell
            return cell
        case .collections:
            let cell = tableView.dequeueReusableCell(with: ProfileSelectableOptionTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.collectionOptionsCells[indexPath.row]
            return cell
        case .groups:
            let cell = tableView.dequeueReusableCell(with: ProfileSelectableOptionTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.groupOptionsCells[indexPath.row]
            return cell
        case .signOut:
            let cell = ProfileSignOutTableViewCell(style: .default, reuseIdentifier: nil)
            return cell
        }
    }
    
}

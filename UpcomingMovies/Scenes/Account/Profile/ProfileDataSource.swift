//
//  ProfileDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class ProfileDataSource: NSObject, UITableViewDataSource {
    
    private var viewModel: ProfileViewModel?
    
    init(viewModel: ProfileViewModel?) {
        self.viewModel = viewModel
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.viewState.value.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        switch viewModel.section(at: section) {
        case .collections:
            return viewModel.collectionOptionsCells.count
        case .signOut:
            return 1
        case .accountInfo:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        switch viewModel.section(at: indexPath.section) {
        case .accountInfo:
            let cell = tableView.dequeueReusableCell(with: ProfileAccountInfoTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.userInfoCell
            cell.selectionStyle = .none
            return cell
        case .collections:
            let cell = tableView.dequeueReusableCell(with: ProfileCollectionTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.collectionOptionsCells[indexPath.row]
            return cell
        case .signOut:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = "Sign out"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = ColorPalette.redColor
            cell.textLabel?.font = FontHelper.light(withSize: 16.0)
            return cell
        }
    }
    
}

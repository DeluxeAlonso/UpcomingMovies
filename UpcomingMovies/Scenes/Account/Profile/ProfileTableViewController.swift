//
//  ProfileViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: class {

    func profileViewController(_ profileViewController: ProfileTableViewController, didTapFavoritesSetting tapped: Bool)
    
    func profileViewController(_ profileViewController: ProfileTableViewController, didTapSignOutButton tapped: Bool)
    
}

class ProfileTableViewController: UITableViewController {
    
    private var dataSource: ProfileDataSource!
    
    weak var delegate: ProfileViewControllerDelegate?
    
    var viewModel: ProfileViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.registerNib(cellType: ProfileSettingTableViewCell.self)
    }
    
    private func setupDataSource() {
        dataSource = ProfileDataSource(viewModel: viewModel)
        tableView.dataSource = dataSource
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        setupDataSource()
    }
    
    // MARK: - Actions
    
    @IBAction func signOutButtonAction(_ sender: Any) {
       delegate?.profileViewController(self, didTapSignOutButton: true)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        switch viewModel.section(at: indexPath.section) {
        case .settings:
            delegate?.profileViewController(self, didTapFavoritesSetting: true)
        case .signOut:
            delegate?.profileViewController(self, didTapSignOutButton: true)
        case .userInfo:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else { return 0 }
        switch viewModel.section(at: indexPath.section) {
        case .settings, .userInfo, .signOut:
            return 50.0
        }
    }

}

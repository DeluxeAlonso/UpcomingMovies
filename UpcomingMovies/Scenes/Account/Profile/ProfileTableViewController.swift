//
//  ProfileViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: class {

    func profileViewController(_ profileViewController: ProfileTableViewController, didTapCollection collection: ProfileCollectionOption)
    
    func profileViewController(_ profileViewController: ProfileTableViewController, didTapGroup group: ProfileGroupOption)
    
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
        tableView.registerNib(cellType: ProfileAccountInfoTableViewCell.self)
        tableView.registerNib(cellType: ProfileSelectableOptionTableViewCell.self)
        tableView.register(cellType: ProfileSignOutTableViewCell.self)
    }
    
    private func setupDataSource() {
        dataSource = ProfileDataSource(viewModel: viewModel)
        tableView.dataSource = dataSource
    }
    
    private func reloadAccountInfo() {
        setupDataSource()
        tableView.performBatchUpdates({
            self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
        }, completion: nil)
    }
    
    private func showSignOutActionSheet() {
        let signOutAction = UIAlertAction(title: "Sign out",
                                          style: .destructive) { _ in
            self.delegate?.profileViewController(self, didTapSignOutButton: true)
        }
        showSimpleActionSheet(title: "Are you sure you want to sign out?",
                              message: nil, action: signOutAction)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel?.reloadAccountInfo = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.reloadAccountInfo()
        }
        setupDataSource()
        viewModel?.getAccountDetails()
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
        case .collections:
            let collectionOption = viewModel.collectionOption(at: indexPath.row)
            delegate?.profileViewController(self, didTapCollection: collectionOption)
        case .groups:
            let groupOption = viewModel.groupOption(at: indexPath.row)
            delegate?.profileViewController(self, didTapGroup: groupOption)
        case .signOut:
            showSignOutActionSheet()
        case .accountInfo:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else { return 0 }
        switch viewModel.section(at: indexPath.section) {
        case .accountInfo:
            return 75.0
        case .collections, .groups, .signOut:
            return 50.0
        }
    }

}

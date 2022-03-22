//
//  ProfileViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, Storyboarded {

    static var storyboardName: String = "Account"

    private var dataSource: ProfileDataSource!

    var viewModel: ProfileViewModelProtocol?
    weak var delegate: ProfileViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.getAccountDetails()
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

        setupDataSource()
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
        let signOutAction = UIAlertAction(title: LocalizedStrings.signOut(),
                                          style: .destructive) { _ in
            self.delegate?.profileViewController(didSignOut: true)
        }
        showSimpleActionSheet(title: LocalizedStrings.signOutConfirmationTitle(),
                              message: nil, action: signOutAction)
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        viewModel?.reloadAccountInfo = { [weak self] in
            guard let self = self else { return }
            self.reloadAccountInfo()
        }
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }

        switch viewModel.section(at: indexPath.section) {
        case .collections, .recommended, .customLists:
            let profileOption = viewModel.profileOption(for: indexPath.section, at: indexPath.row)
            delegate?.profileViewController(didTapProfileOption: profileOption)
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
        case .collections, .recommended, .customLists, .signOut:
            return 50.0
        }
    }

}

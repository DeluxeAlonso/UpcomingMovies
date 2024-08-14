//
//  ProfileViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class ProfileViewController: UITableViewController, Storyboarded {

    static var storyboardName: String = "Account"

    private var dataSource: ProfileDataSource?

    var viewModel: ProfileViewModelProtocol?
    weak var coordinator: ProfileCoordinatorProtocol?
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
        let signOutAction = UIAlertAction(title: viewModel?.signOutTitle,
                                          style: .destructive) { _ in
            self.viewModel?.signOutCurrentUser()
        }
        showSimpleActionSheet(title: viewModel?.signOutConfirmationTitle,
                              message: nil, action: signOutAction)
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        viewModel?.reloadAccountInfo.bind({ [weak self] _ in
            guard let self = self else { return }
            self.reloadAccountInfo()
        }, on: .main)
        viewModel?.didUpdateAuthenticationState.bindAndFire({ [weak self] authState in
            guard let self = self, let authState else { return }
            self.delegate?.didUpdateAuthenticationState(authState)
        }, on: .main)
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
            return UITableView.automaticDimension
        case .collections, .recommended, .customLists, .signOut:
            return 50.0
        }
    }

}

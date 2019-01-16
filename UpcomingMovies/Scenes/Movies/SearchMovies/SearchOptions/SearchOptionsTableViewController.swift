//
//  SearchOptionsTableViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SearchOptionsTableViewController: UITableViewController {
    
    var viewModel: SearchOptionsViewModel? {
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
        tableView.register(DefaultSearchOptionTableViewCell.self, forCellReuseIdentifier: DefaultSearchOptionTableViewCell.identifier)
        
        tableView.register(GenreSearchOptionTableViewCell.self, forCellReuseIdentifier: GenreSearchOptionTableViewCell.identifier)
        tableView.register(UINib(nibName: GenreSearchOptionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GenreSearchOptionTableViewCell.identifier)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.viewState.value.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else {
            return nil
        }
        let sections = viewModel.viewState.value.sections
        return sections[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        let sections = viewModel.viewState.value.sections
        switch sections[section] {
        case .recentlyVisited:
            return 1
        case .defaultSearches:
            return viewModel.defaultSearchOptionsCells.count
        case .genres:
            return viewModel.genreCells.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return  UITableViewCell() }
        let sections = viewModel.viewState.value.sections
        switch sections[indexPath.section] {
        case .recentlyVisited:
            return UITableViewCell()
        case .defaultSearches:
            return defaultSearchOptionDataSource(tableView, at: indexPath)
        case .genres:
            return genreSearchOptionDataSource(tableView, at: indexPath)
        }
    }
    
    private func defaultSearchOptionDataSource(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSearchOptionTableViewCell.identifier, for: indexPath) as! DefaultSearchOptionTableViewCell
        cell.viewModel = viewModel?.defaultSearchOptionsCells[indexPath.row]
        return cell
    }
    
    private func genreSearchOptionDataSource(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreSearchOptionTableViewCell.identifier, for: indexPath) as! GenreSearchOptionTableViewCell
        cell.viewModel = viewModel?.genreCells[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delgate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50.0
    }

}

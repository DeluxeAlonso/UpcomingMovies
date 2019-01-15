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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
    
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

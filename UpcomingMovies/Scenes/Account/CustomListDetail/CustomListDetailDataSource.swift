//
//  CustomListDetailDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/21/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CustomListDetailDataSource: NSObject, UITableViewDataSource {
    
    let viewModel: CustomListDetailViewModelProtocol

    // MARK: - Initializers
    
    init(viewModel: CustomListDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MovieTableViewCell.self,
                                                 for: indexPath)
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }
    
}

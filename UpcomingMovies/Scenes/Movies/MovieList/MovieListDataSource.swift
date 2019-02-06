//
//  MovieListDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieListDataSource: NSObject, UITableViewDataSource {
    
    private let viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as!
        MovieTableViewCell
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }
    
}

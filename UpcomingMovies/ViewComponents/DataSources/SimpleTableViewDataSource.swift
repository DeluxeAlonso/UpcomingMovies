//
//  SimpleTableViewDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SimpleTableViewDataSource<ViewModel>: NSObject, UITableViewDataSource {
    
    typealias CellConfigurator = (ViewModel, UITableViewCell) -> Void
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    var cellViewModels: [ViewModel]
    
    // MARK: - Initializers
    
    init(cellViewModels: [ViewModel], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.cellViewModels = cellViewModels
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = cellViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(viewModel, cell)
        return cell
    }

}

extension SimpleTableViewDataSource where ViewModel == MovieCellViewModel {
    
    static func make(for cellViewModels: [MovieCellViewModel],
                     reuseIdentifier: String = MovieTableViewCell.identifier) -> SimpleTableViewDataSource {
        return SimpleTableViewDataSource(cellViewModels: cellViewModels,
                                              reuseIdentifier: reuseIdentifier,
                                              cellConfigurator: { (viewModel, cell) in
                                                let cell = cell as! MovieTableViewCell
                                                cell.viewModel = viewModel
        })
    }
    
}

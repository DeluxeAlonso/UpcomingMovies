//
//  SimpleTableViewDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SimpleTableViewDataSource<ViewModel, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    
    typealias CellConfigurator = (ViewModel, Cell) -> Void
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    private var cellViewModels: [ViewModel]
    
    // MARK: - Initializers
    
    init(cellViewModels: [ViewModel], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.cellViewModels = cellViewModels
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = cellViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
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

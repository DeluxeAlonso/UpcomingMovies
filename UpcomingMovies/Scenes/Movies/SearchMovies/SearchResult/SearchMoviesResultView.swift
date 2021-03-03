//
//  SearchMoviesResultView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/22/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SearchMoviesResultView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    lazy var loadingFooterView: LoadingFooterView = {
        let footerView = LoadingFooterView()
        footerView.frame = LoadingFooterView.recommendedFrame
        footerView.startAnimating()
        return footerView
    }()
    
    var tableViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     tableViewBottomConstraint])
    }

}
